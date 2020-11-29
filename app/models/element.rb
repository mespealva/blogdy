class Element < ApplicationRecord
  belongs_to :post
  validates :element_type, inclusion: { in: ['paragraph', 'image', 'tag'] }

  has_rich_text :content
  has_one_attached :image

  def paragraph?
    element_type == 'paragraph'
  end
  
  def image?
    element_type == 'image'
  end

  def tag?
    element_type == 'tag'
  end

  scope :first_element , -> do 
    Element.where(element_type: 'paragraph').first 
  end

  acts_as_list scope: :post
end
