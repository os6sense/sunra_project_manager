class DistributionAudit < ActiveRecord::Base
  attr_accessible :email_address, :emailed_at, :format_id, :group_id
end
