class AddUrLtoBug < ActiveRecord::Migration[7.0]
  def change
    add_column :bugs, :url, :string
  end
end
