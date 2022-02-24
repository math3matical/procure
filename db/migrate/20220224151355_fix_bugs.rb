class FixBugs < ActiveRecord::Migration[7.0]
  def change
    change_column :bugs, :summar, :text
    rename_column :bugs, :summar, :summary

  end
end
