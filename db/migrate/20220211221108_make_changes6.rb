class MakeChanges6 < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :case_coverages, :engineers
    rename_column :case_coverages, :employee_id, :engineer_id
    rename_column :bug_coverages, :employee_id, :engineer_id
    
  end
end
