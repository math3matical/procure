class UpdateAccountNumerToString < ActiveRecord::Migration[7.0]
  def change
    change_column :bugs, :number, :string
    change_column :solutions, :number, :string
    change_column :cases, :number, :string
  end
end
