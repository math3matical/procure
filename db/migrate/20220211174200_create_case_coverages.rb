class CreateCaseCoverages < ActiveRecord::Migration[7.0]
  def change
    create_table :case_coverages do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :case, null: false, foreign_key: true

      t.timestamps
    end
  end
end
