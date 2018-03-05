class AddCreatedAtIndexToFoundations < ActiveRecord::Migration[5.1]
  def change
    add_index :foundations, :created_at
  end
end
