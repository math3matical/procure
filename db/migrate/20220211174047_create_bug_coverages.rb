class CreateBugCoverages < ActiveRecord::Migration[7.0]
  def change
    create_table :bug_coverages do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :bug, null: false, foreign_key: true

      t.timestamps
    end
  end
end
