class Solution < ApplicationRecord
  include Visible
 
  has_many :solution_coverages, dependent: :destroy
  has_many :engineers, :through => :solution_coverages

  has_many :comments, as: :commentable, dependent: :destroy
  has_one :satellite_tag, as: :satellite_taggable, dependent: :destroy
  has_one :provision_tag, as: :provision_taggable, dependent: :destroy
  has_one :network_tag, as: :network_taggable, dependent: :destroy

  validates :title, presence: true
  validates :number, presence: true, length: { minimum: 8, maximum: 8 }

  def self.search(search)
    search ||=""
    unless search == ""
      @stuff = Solution.where('title LIKE ?', "%#{search}%").all
      @stuff2 = Solution.where('notes LIKE ?', "%#{search}%").all
      @stuff3 = Solution.where('number LIKE ?', "%#{search}%").all
      ids ||=[]
      Solution.all.each do |solution|
        if solution.engineers.where('first_name LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Solution.where(id: solution.id).ids
          @stuff = Solution.where(id: ids) 
        end
        if solution.engineers.where('last_name LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Solution.where(id: solution.id).ids
          @stuff = Solution.where(id: ids) 
        end
      end

      Solution.all.each do |solution|
        if solution.comments.where('body LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Solution.where(id: solution.id).ids
          @stuff = Solution.where(id: ids) 
        end
        if solution.comments.where('commenter LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Solution.where(id: solution.id).ids
          @stuff = Solution.where(id: ids) 
        end
      end

      ids = @stuff.ids + @stuff2.ids
      @stuff = Solution.where(id: ids)
      ids = @stuff.ids + @stuff3.ids
      @stuff = Solution.where(id: ids)

    else
      Solution.all
    end
  end


end
