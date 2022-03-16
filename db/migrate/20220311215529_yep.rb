class Yep < ActiveRecord::Migration[7.0]
  def change
    add_column :cases, :case_tag, :string
    rename_column :solutions, :tags, :solution_tag
  end
end
