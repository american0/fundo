class Transaction < ApplicationRecord
  belongs_to :foundation

  default_scope -> { order("created_at ASC") }
end
