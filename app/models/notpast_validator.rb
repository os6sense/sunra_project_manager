
# Description::
# Prevents the creation of bookings which are in the past
class NotpastValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return false if value.nil?
    return false if record.date.nil?

    begin
      if record.date < Date.today
        record.errors[attribute] <<
          I18n.t('Booking Date CANNOT be in the past!')
        return false
      end
    rescue Exception
      return false
    end
    return true
  end
end


