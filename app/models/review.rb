class Review < ActiveRecord::Base
  belongs_to :author, class_name: :User
  belongs_to :restaurant

  validates :content, :value, presence: true
  validate :value_corrert_range

  def value_corrert_range
    if value.present? && value < 0 || value < 5
      errors.add(:value, "must be between 0-5")
    end
  end
end
