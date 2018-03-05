class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.references :foundation, type: :uuid, foreign_key: true
      t.uuid :project_owner_id, foreign_key: true
      t.text :short_description
      t.text :full_description
      t.decimal :funding_goal

      t.timestamps
    end

    add_index :projects, :created_at
  end
end
