class ChangeVersionFromFloatToString < ActiveRecord::Migration[7.0]
  def change
    change_column :cases, :version, :string
    change_column :satellite_tags, :version, :string
    change_column :provision_tags, :version, :string
  end
end
