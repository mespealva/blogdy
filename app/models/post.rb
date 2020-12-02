class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  is_impressionable
  acts_as_votable
  
  belongs_to :author
  has_many :elements, -> { order(position: :asc) }
  
  has_one_attached :header_image

  validates :title, uniqueness: true
  validates_presence_of :title
  validates_presence_of :header_image

  scope :published, -> do
    where(published: true)
  end

  scope :most_recently_published, -> do
    order(published_at: :desc)
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

end
