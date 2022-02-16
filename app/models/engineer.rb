class Engineer < ApplicationRecord
  include Visible

  has_many :solution_coverages, dependent: :destroy
  has_many :bug_coverages, dependent: :destroy
  has_many :case_coverages, dependent: :destroy
  has_many :bugs, :through => :bug_coverages
  has_many :cases, :through => :case_coverages
  has_many :solutions, :through => :solution_coverages

  has_many :comments, as: :commentable, dependent: :destroy
  
  validates :last_name, presence: true
  validates :first_name, presence: true

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
