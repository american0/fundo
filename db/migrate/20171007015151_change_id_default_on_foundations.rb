class ChangeIdDefaultOnFoundations < ActiveRecord::Migration[5.1]
  def change
    change_column_default :foundations, :id, from: nil, to: "gen_random_uuid()"
  end
end
