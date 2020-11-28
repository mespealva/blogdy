class Post < ApplicationRecord
  belongs_to :author
  has_many :elements, -> { order(position: :asc) }

  has_one_attached :header_image

  validates :title, uniqueness: true
  validates_presence_of :title

  scope :published, -> do
    where(published: true)
  end
end
