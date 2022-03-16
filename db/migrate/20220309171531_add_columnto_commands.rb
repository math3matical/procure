class AddColumntoCommands < ActiveRecord::Migration[7.0]
  def change
    add_column :commands, :body, :text
  end
end
