class AddColumnstoCases < ActiveRecord::Migration[7.0]
  def change
    add_column :cases, :sbr, :string
    add_column :cases, :product, :string
    add_column :cases, :issue, :text
    add_column :cases, :summary, :string
    add_column :cases, :bug_number, :string
    add_column :cases, :bug_summary, :text
    add_column :cases, :customer_contact, :string
    add_column :cases, :customer_name, :string
  end
end
