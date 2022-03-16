class Case < ApplicationRecord
  include Visible
  
  has_many :engineer_tags, as: :engineer_taggable, dependent: :destroy
  has_many :engineers, :through => :engineer_tags
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :tags, as: :tag_taggable, dependent: :destroy
  has_many :tag_items, :through => :tags
  has_one :satellite_tag, as: :satellite_taggable, dependent: :destroy
  has_one :provision_tag, as: :provision_taggable, dependent: :destroy
  has_one :network_tag, as: :network_taggable, dependent: :destroy
  
  validates :title, presence: true
  validates :number, presence: true, length: { minimum: 8, maximum: 8 }
  validates_uniqueness_of :number

#https://dev.to/spidergears/rails-active-record-validation-messages-4dcf
# Didn't seem to work as creator said.  The model value type is still returned first.
#  validates :number,
#    uniqueness: {
#      message: ->(object, data) do
#        " #{data[:value]} is already taken!"
#      end
#    }

  def self.search2(search,engineer)
    ids = []
    @stuff = self.search(search)
    @stuff.ids.each do |id|
      if engineer.cases.ids.include?(id)
        ids << id
      end
    end
    Case.where(id: ids)
  end

  def self.search(search)
    search ||=""
    search = search.gsub(/[[:space:]]+/, "")
    unless search == ""
      @stuff = Case.joins(:tag_items).where('tag_items.name LIKE ?', "%#{search}%")
      @stuff2 = Case.joins(:engineers).where('engineers.first_name LIKE :search or engineers.last_name LIKE :search', search: "%#{search}%")
      @stuff3 = Case.joins(:comments).where('comments.body LIKE ?', "%#{search}%")
      @stuff4 = Case.where('title LIKE :search or notes LIKE :search or summary LIKE :search or number LIKE :search', search: "%#{search}%")
      ids = []
      ids = @stuff.ids + @stuff2.ids + @stuff3.ids + @stuff4.ids
      @stuff = Case.where(id: ids)
    else
      Case.all
    end
  end
end
