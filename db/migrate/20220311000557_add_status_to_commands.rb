class AddStatusToCommands < ActiveRecord::Migration[7.0]
  def change
    add_column :commands, :status, :string
  end
end
