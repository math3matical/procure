class CreateSolutions < ActiveRecord::Migration[7.0]
  def change
    create_table :solutions do |t|
      t.string :title
      t.integer :number
      t.integer :importance
      t.text :notes

      t.timestamps
    end
  end
end
