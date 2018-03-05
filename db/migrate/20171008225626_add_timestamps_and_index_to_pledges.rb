class AddTimestampsAndIndexToPledges < ActiveRecord::Migration[5.1]
  def change
    add_column :pledges, :created_at, :datetime
    add_column :pledges, :updatd_at, :datetime

    add_index :pledges, :created_at
  end

end
