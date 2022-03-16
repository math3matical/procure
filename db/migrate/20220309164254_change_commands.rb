class ChangeCommands < ActiveRecord::Migration[7.0]
  def change
    remove_reference :commands, :tags
  end
end
