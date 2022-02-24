class Engineer < ApplicationRecord
  include Visible
  
  has_many :engineer_tags, dependent: :destroy
  has_many :bugs, :through =>  :engineer_tags, :source => :engineer_taggable, :source_type => "Bug"

  has_many :solution_coverages, dependent: :destroy
  has_many :bug_coverages, dependent: :destroy
  has_many :case_coverages, dependent: :destroy
  has_many :bugs, :through => :bug_coverages
  has_many :cases, :through => :case_coverages
  has_many :solutions, :through => :solution_coverages

  has_many :comments, as: :commentable, dependent: :destroy
  
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
      @stuff = Engineer.where('first_name LIKE ?', "%#{search}%").all
      @stuff2 =Engineer.where('last_name LIKE ?', "%#{search}%").all
      ids = @stuff.ids + @stuff2.ids
      @stuff = Engineer.where(id: ids)
    else
      Engineer.all
    end
  end

end
