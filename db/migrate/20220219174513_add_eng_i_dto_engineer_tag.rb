class AddEngIDtoEngineerTag < ActiveRecord::Migration[7.0]
  def change
    add_column :engineer_tags, :engineer_id, :integer
    add_column :engineer_tags, :status, :string
  end
end
