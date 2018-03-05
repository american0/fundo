class RenameCountryCodeOnFoundations < ActiveRecord::Migration[5.1]
  def change
    rename_column :foundations, :country_code, :country_alpha2
  end
end
