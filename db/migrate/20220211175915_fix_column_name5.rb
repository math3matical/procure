class FixColumnName5 < ActiveRecord::Migration[7.0]
  def change
    add_column :solutions, :status, :string
    add_column :solution_coverages, :status, :string
    add_column :bugs, :status, :string
    add_column :bug_coverages, :status, :string
    add_column :engineers, :status, :string
    add_column :cases, :status, :string
    add_column :case_coverages, :status, :string
  end
end
