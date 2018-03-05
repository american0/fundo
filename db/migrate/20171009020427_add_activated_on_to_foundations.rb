class AddActivatedOnToFoundations < ActiveRecord::Migration[5.1]
  def change
    add_column :foundations, :activated_on, :datetime
  end
end
