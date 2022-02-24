class Case < ApplicationRecord
  include Visible

  #has_many :case_coverages, dependent: :destroy
  #has_many :engineers, :through => :case_coverages 
  
  has_many :engineer_tags, as: :engineer_taggable, dependent: :destroy
  has_many :engineers, :through => :engineer_tags

  has_many :comments, as: :commentable, dependent: :destroy
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

  validates :notes, presence: true

  def self.search2(search,engineer)
    search ||=""
    unless search == ""
      @stuff = Case.where('title LIKE ?', "%#{search}%").all
      @stuff2 =Case.where('notes LIKE ?', "%#{search}%").all
      @stuff3 =Case.where('number LIKE ?', "%#{search}%").all
      Case.all.each do |casse|
        if casse.comments.where('body LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Case.where(id: casse.id).ids
          @stuff = Case.where(id: ids)
        end
        if casse.comments.where('commenter LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Case.where(id: casse.id).ids
          @stuff = Case.where(id: ids)
        end
      end
      ids = @stuff.ids + @stuff2.ids
      @stuff = Case.where(id: ids)
      ids = @stuff.ids + @stuff3.ids
      @stuff = Case.where(id: ids)
      id3=[]
      @stuff.ids.each do |id|
        if engineer.cases.ids.include?(id)
          id3 << id
        end
      end
      Case.where(id: id3)
    else
      engineer.cases
    end
  end

  def self.search(search)
    search ||=""
    unless search == ""
      @stuff = Case.where('title LIKE ?', "%#{search}%").all
      @stuff2 =Case.where('notes LIKE ?', "%#{search}%").all
      @stuff3 =Case.where('number LIKE ?', "%#{search}%").all

      Case.all.each do |casse|
        if casse.engineers.where('first_name LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Case.where(id: casse.id).ids
          @stuff = Case.where(id: ids)
        end
        if casse.engineers.where('last_name LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Case.where(id: casse.id).ids
          @stuff = Case.where(id: ids)
        end
      end

      Case.all.each do |casse|
        if casse.comments.where('body LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Case.where(id: casse.id).ids
          @stuff = Case.where(id: ids)
        end
        if casse.comments.where('commenter LIKE ?', "%#{search}%").length > 0
          ids = @stuff.ids + Case.where(id: casse.id).ids
          @stuff = Case.where(id: ids)
        end
      end

      ids = @stuff.ids + @stuff2.ids
      @stuff = Case.where(id: ids)
      ids = @stuff.ids + @stuff3.ids
      @stuff = Case.where(id: ids)

    else
      Case.all
    end
  end
end
