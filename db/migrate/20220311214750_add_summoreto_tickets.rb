class AddSummoretoTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :cases, :breaches, :string
    add_column :solutions, :tags, :string
  end
end
