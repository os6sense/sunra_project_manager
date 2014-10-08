class FormatLookup < ActiveRecord::Base
  belongs_to :recording_format
  attr_accessible :id,
                  :name,
                  :extension
end
