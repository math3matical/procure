class CreateSolutionCoverages < ActiveRecord::Migration[7.0]
  def change
    create_table :solution_coverages do |t|
      t.references :engineer, null: false, foreign_key: true
      t.references :solution, null: false, foreign_key: true

      t.timestamps
    end
  end
end
