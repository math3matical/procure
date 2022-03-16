class Solution < ApplicationRecord
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
  validates :number, presence: true, length: { minimum: 7, maximum: 7 }
  validates_uniqueness_of :number

  def self.search2(search,engineer)
    ids = []
    @stuff = self.search(search)
    @stuff.ids.each do |id|
      if engineer.solutions.ids.include?(id)
        ids << id
      end
    end
    Solution.where(id: ids)
  end

  def self.search(search)
    search ||=""
    search = search.gsub(/[[:space:]]+/, "")
    unless search == ""
      @stuff = Solution.joins(:tag_items).where('tag_items.name LIKE ?', "%#{search}%")
      @stuff2 = Solution.joins(:engineers).where('engineers.first_name LIKE :search or engineers.last_name LIKE :search', search: "%#{search}%")
      @stuff3 = Solution.joins(:comments).where('comments.body LIKE ?', "%#{search}%")
      @stuff4 = Solution.where('title LIKE :search or notes LIKE :search or number LIKE :search', search: "%#{search}%")
      ids = []
      ids = @stuff.ids + @stuff2.ids + @stuff3.ids + @stuff4.ids
      @stuff = Solution.where(id: ids)
    else
      Solution.all
    end
  end
end
