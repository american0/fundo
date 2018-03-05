class Payment < ApplicationRecord
  belongs_to :pledge
  belongs_to :foundation
end
