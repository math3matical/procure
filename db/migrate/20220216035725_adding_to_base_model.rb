class AddingToBaseModel < ActiveRecord::Migration[7.0]
  def change
    add_column :cases, :fts, :boolean
    add_column :cases, :collaboration, :boolean
    add_column :cases, :rme, :boolean
    add_column :cases, :drd, :boolean
    add_column :cases, :views, :integer
    add_column :cases, :watcher, :datetime
    add_column :cases, :customer, :string
    add_column :cases, :account_number, :integer
    add_column :cases, :owner_first, :string
    add_column :cases, :owner_last, :string
  end
end
