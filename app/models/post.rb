class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]
  
  belongs_to :author
  has_many :elements, -> { order(position: :asc) }
  
  has_one_attached :header_image

  validates :title, uniqueness: true
  validates_presence_of :title

  scope :published, -> do
    where(published: true)
  end

  def should_generate_new_friendly_id?
    title_changed?
  end

end
