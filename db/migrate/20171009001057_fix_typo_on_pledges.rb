class FixTypoOnPledges < ActiveRecord::Migration[5.1]
  def change
    rename_column :pledges, :updatd_at, :updated_at
  end
end
