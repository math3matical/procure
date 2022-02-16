class CreateSatelliteTags < ActiveRecord::Migration[7.0]
  def change
    create_table :satellite_tags do |t|
      t.float :version
      t.boolean :pulp
      t.references :satellite_taggable, polymorphic: true
      t.boolean :postgres
      t.boolean :foreman_proxy
      t.boolean :installer
      t.boolean :publish
      t.boolean :promote
      t.boolean :contentview
      t.boolean :capsule
      t.boolean :sync
      t.boolean :repository
      t.boolean :metadata
      t.boolean :mongo
      t.boolean :redis
      t.boolean :puma
      t.boolean :http
      t.boolean :reports
      t.boolean :ui

      t.timestamps
    end
  end
end
