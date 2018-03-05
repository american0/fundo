class AddTitleToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :title, :string
  end
end
