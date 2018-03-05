class CreateFoundations < ActiveRecord::Migration[5.1]
  def change
    create_table :foundations do |t|
      t.string :country_code
      t.string :local_currency
      t.string :postal_code
      t.integer :min_starting_funds
      t.integer :min_participants
      t.datetime :activation_deadline

      t.timestamps
    end
  end
end
