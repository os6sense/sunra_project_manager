class FileOpsAudit < ActiveRecord::Base
  attr_accessible :encrypted_at, :format_id, :group_id, :uploaded_at
end
