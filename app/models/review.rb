class Review < ApplicationRecord

  belongs_to :product

  validates :product_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates :rating, presence: true
  validate :rating_must_be_between_1_and_10

  private

  def rating_must_be_between_1_and_10
    unless self.rating >= 1 && self.rating <= 10
      errors.add(:rating, "Must be a value between 1 and 10")
    end
  end

end
