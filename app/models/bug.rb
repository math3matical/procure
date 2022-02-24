class Bug < ApplicationRecord
  include Visible
  auto_strip_attributes :number

#  has_many :bug_coverages, dependent: :destroy
#  has_many :engineers, :through => :bug_coverages

  has_many :engineer_tags, as: :engineer_taggable, dependent: :destroy
  has_many :engineers, :through => :engineer_tags 

  has_many :comments, as: :commentable, dependent: :destroy
  has_one :satellite_tag, as: :satellite_taggable, dependent: :destroy
  has_one :provision_tag, as: :provision_taggable, dependent: :destroy
  has_one :network_tag, as: :network_taggable, dependent: :destroy

  validates :title, presence: true
  validates :number, presence: true, length: { minimum: 7, maximum: 7 }
  validates_uniqueness_of :number

  def self.search2(search,engineer)
    search ||=""
    unless search == ""
      @stuff = Bug.where('title LIKE ?', "%#{search}%").all
      @stuff2 =Bug.where('notes LIKE ?', "%#{search}%").all
      @stuff3 =Bug.where('number LIKE ?', "%#{search}%").all
      Bug.all.each do |bug|
        if bug.comments.where('body LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Bug.where(id: bug.id).ids
          @stuff = Bug.where(id: ids)
        end
        if bug.comments.where('commenter LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Bug.where(id: bug.id).ids
          @stuff = Bug.where(id: ids)
        end
      end
      ids = @stuff.ids + @stuff2.ids
      @stuff = Bug.where(id: ids)
      ids = @stuff.ids + @stuff3.ids
      @stuff = Bug.where(id: ids)
      id3=[]
      @stuff.ids.each do |id|
        if engineer.bugs.ids.include?(id)
          id3 << id
        end
      end
      Bug.where(id: id3)
    else
      engineer.bugs
    end
  end

  def self.search(search)
    search ||=""
    unless search == ""
      @stuff = Bug.where('title LIKE ?', "%#{search}%").all
      @stuff2 =Bug.where('notes LIKE ?', "%#{search}%").all
      @stuff3 =Bug.where('number LIKE ?', "%#{search}%").all
      ids ||=[]
      
      Bug.all.each do |bug|
        if bug.engineers.where('first_name LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Bug.where(id: bug.id).ids
          @stuff = Bug.where(id: ids)
        end
        if bug.engineers.where('last_name LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Bug.where(id: bug.id).ids
          @stuff = Bug.where(id: ids)
        end
      end

      Bug.all.each do |bug|
        if bug.comments.where('body LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Bug.where(id: bug.id).ids
          @stuff = Bug.where(id: ids)
        end
        if bug.comments.where('commenter LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Bug.where(id: bug.id).ids
          @stuff = Bug.where(id: ids)
        end
      end

      ids = @stuff.ids + @stuff2.ids
      @stuff = Bug.where(id: ids)
      ids = @stuff.ids + @stuff3.ids
      @stuff = Bug.where(id: ids)

    else
      Bug.all
    end
  end
end
