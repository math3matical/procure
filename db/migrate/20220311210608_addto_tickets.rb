class AddtoTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :solutions, :abstract, :text
    add_column :solutions, :author, :string
    add_column :solutions, :boostProduct, :string
    add_column :solutions, :inferred_tag, :string
    add_column :solutions, :state, :string
    add_column :solutions, :url, :string
    add_column :solutions, :product, :string
    add_column :solutions, :tag, :string
    add_column :cases, :link, :string
    add_column :cases, :url, :string
    add_column :cases, :region, :string
    add_column :cases, :handover, :boolean
    add_column :cases, :closed, :boolean
    add_column :cases, :escalated, :boolean
    add_column :cases, :ownerIRC, :string
    add_column :cases, :state, :string
    add_column :cases, :strategic, :string
    add_column :cases, :tags, :string
    add_column :bugs, :fixed_in, :string
    add_column :bugs, :release_notes, :string
    add_column :bugs, :component, :string
    add_column :bugs, :keywords, :string
    add_column :bugs, :target_milestone, :string
    add_column :bugs, :last_change, :string
    add_column :bugs, :cc, :text
    add_column :bugs, :cc_detail, :text
  end
end
