class Engineer < ApplicationRecord
  include Visible
  
  has_many :engineer_tags, dependent: :destroy
  has_many :bugs, :through =>  :engineer_tags, :source => :engineer_taggable, :source_type => "Bug"
  has_many :cases, :through =>  :engineer_tags, :source => :engineer_taggable, :source_type => "Case"
  has_many :solutions, :through =>  :engineer_tags, :source => :engineer_taggable, :source_type => "Solution"
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :tags, as: :tag_taggable, dependent: :destroy
  has_many :tag_items, :through => :tags
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validate :first_last 

  def first_last
    last = Engineer.where('lower(last_name) = ?', last_name.downcase)
    last.each do |l|
      if l.first_name.downcase.eql? first_name.downcase
        unless l.id.eql? id
          errors.add(:last_name, "has already been used") 
        end
      end
    end
  end

  def self.search(search)
    search ||=""
    unless search == ""
      search = search.gsub(/[[:space:]]+/, "")
      @stuff = Engineer.where('first_name LIKE :search or last_name LIKE :search or irc LIKE :search or position LIKE :search', search: "%#{search}%")
#      ids = @stuff.ids + @stuff2.ids
#      @stuff = Engineer.where(id: ids)
    else
      Engineer.all
    end
  end
end
