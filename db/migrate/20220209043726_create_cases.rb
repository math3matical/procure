class CreateCases < ActiveRecord::Migration[7.0]
  def change
    create_table :cases do |t|
      t.float :version
      t.string :title
      t.integer :number
      t.integer :comments
      t.integer :importance
      t.text :notes

      t.timestamps
    end
  end
end
