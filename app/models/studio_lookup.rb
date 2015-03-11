# ==== Description
# Provides maping between studion id and details
class StudioLookup < ActiveRecord::Base
  belongs_to :booking

  attr_accessible :id,
                  :facility_name,
                  :studio_name,
                  :mdns_localname,
                  :ip_fallback,
                  :phone,
                  :active

  def self.studio_name_from_id(id)
    return "- missing lookup (#{id}) -" if (record = where(id: id)).first.nil?
    record.first.studio_name
  end

  def self.all_studio_names
    StudioLookup.find(:all, select: 'id, studio_name')
  end
end
