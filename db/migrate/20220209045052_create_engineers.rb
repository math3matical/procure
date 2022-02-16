class CreateEngineers < ActiveRecord::Migration[7.0]
  def change
    create_table :engineers do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.string :irc

      t.timestamps
    end
  end
end
