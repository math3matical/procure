class MakeChanges < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :case_coverages, :employees
  end
end
