class Project < ApplicationRecord
  belongs_to :foundation
  belongs_to :project_owner, class_name: "User", foreign_key: :project_owner_id

  default_scope -> { order("created_at ASC") }
end
