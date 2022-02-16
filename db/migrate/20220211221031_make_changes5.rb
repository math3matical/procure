class MakeChanges5 < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :bug_coverages, :engineers
  end
end
