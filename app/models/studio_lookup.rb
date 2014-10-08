class StudioLookup < ActiveRecord::Base
  belongs_to :booking
  attr_accessible :id,
                  :facility_name,
                  :studio_name,
                  :mdns_localname,
                  :ip_fallback,
                  :phone,
                  :active
end
