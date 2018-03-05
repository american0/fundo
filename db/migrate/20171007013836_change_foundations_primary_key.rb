class ChangeFoundationsPrimaryKey < ActiveRecord::Migration[5.1]
  def change
   add_column :foundations, :uuid, :uuid, null: false

   change_table :foundations do |t|
     t.remove :id
     t.rename :uuid, :id
   end

   execute "ALTER TABLE foundations ADD PRIMARY KEY (id);"
  end
end
