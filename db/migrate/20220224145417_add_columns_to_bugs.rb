class AddColumnsToBugs < ActiveRecord::Migration[7.0]
  def change
    add_column :bugs, :proudct, :string
    add_column :bugs, :assigned_to, :string
    add_column :bugs, :creator, :string
    add_column :bugs, :severity, :string
    add_column :bugs, :qa_contact, :string
    add_column :bugs, :version, :string
    add_column :bugs, :whiteboard, :string
    add_column :bugs, :target_release, :string
    add_column :bugs, :summar, :text
  end
end
