# Description::
# Validate the the end time is greater than the start time
class EndtimegreaterValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return false if value.nil?
    return false if record.start_time.nil? || record.end_time.nil?

    begin
      if record.start_time >= record.end_time
        record.errors[attribute] << I18n.t('Start time MUST be Earlier than End time!')
        return false
      end
    rescue Exception => e
      puts "EndTImeValidator - Exception : #{e}"
      return false
    end
    return true
  end
end


