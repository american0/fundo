class ChangeUsersPrimaryKey < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :users do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    execute "ALTER TABLE users ADD PRIMARY KEY (id);"

    add_index :users, :created_at
  end
end
