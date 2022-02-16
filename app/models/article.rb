class Article < ApplicationRecord
  include Visible

  has_many :comments, as: :commentable, dependent: :destroy

  has_one :satellite_tag, as: :satellite_taggable, dependent: :destroy
  has_one :provision_tag, as: :provision_taggable, dependent: :destroy
  has_one :network_tag, as: :network_taggable, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  def self.search(search)
    search ||=""
    unless search == ""
      @stuff = Article.where('title LIKE ?', "%#{search}%").all
      @stuff2 =Article.where('body LIKE ?', "%#{search}%").all
      ids = @stuff.ids + @stuff2.ids
      @stuff = Article.where(id: ids)
    else
      Article.all
    end
  end
end
