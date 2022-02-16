class MakeChanges7 < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :case_coverages, :engineers, column: :engineer_id, primary_key: :id
    add_foreign_key :bug_coverages, :engineers, column: :engineer_id, primary_key: :id
  end
end
