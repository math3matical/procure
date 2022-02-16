class FixColumnName2 < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :comentable_type, :string
  end
end
