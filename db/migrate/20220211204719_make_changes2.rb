class MakeChanges2 < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :bug_coverages, :employees
    add_foreign_key :bug_coverages, :engineers, column: :id
    add_foreign_key :case_coverages, :engineers, column: :id
  end
end
