class AddCaseOwner < ActiveRecord::Migration[7.0]
  def change
    add_column :cases, :case_owner, :string
  end
end
