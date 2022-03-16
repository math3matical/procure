class AddmoretoTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :cases, :description, :text
    add_column :solutions, :created, :string
  end
end
