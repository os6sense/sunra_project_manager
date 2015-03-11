# Description::
# Ensures that no booking is created which overlaps with the date and time 
# of another booking
class BookingslotValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return false if record.nil? || attribute.nil?

    begin
      # sqllite so no time diff hence jumping through hoops here  note that if
      # record.id = NULL and we pass that to the query, we get nothing returned
      # hence the ternary.
      possibly_conflicting = Booking.where(
                               "date = ? AND facility_studio = ? AND id != ?",
                               record.date, record.facility_studio, 
                               record.id ? record.id : 0).all

      possibly_conflicting.each do |booking|
        # we have to test this here rather than in the sql if using sqllight
        if (booking.start_time - record.end_time) * (record.start_time - booking.end_time) >= 0
          record.errors[attribute] <<
            I18n.t("#{booking.project.project_name} :: " +
              "Start Time: #{booking.start_time} - End Time: #{booking.end_time}")
        end
      end

      if (i = record.errors[attribute].length) > 0
        record.errors[attribute].unshift I18n.t("Booking Overlaps with #{i} existing bookings")
        return false
      end

    rescue Exception => e
      Logger.debug("Error validating Booking #{e}")
      return false
    end
    return true
  end
end

