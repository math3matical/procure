class Bug < ApplicationRecord
  include Visible

  has_many :bug_coverages, dependent: :destroy
  has_many :engineers, :through => :bug_coverages 

  has_many :comments, as: :commentable, dependent: :destroy
  has_one :satellite_tag, as: :satellite_taggable, dependent: :destroy
  has_one :provision_tag, as: :provision_taggable, dependent: :destroy
  has_one :network_tag, as: :network_taggable, dependent: :destroy

  validates :title, presence: true
  validates :number, presence: true, length: { minimum: 8, maximum: 8 }

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
