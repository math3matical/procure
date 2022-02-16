class MakeChanges4 < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :bug_coverages, :engineers, column: :id, primary_key: :id
  end
end
