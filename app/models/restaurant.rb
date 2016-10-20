class Restaurant < ActiveRecord::Base
  belongs_to :owner, class_name: :User
  has_many :reviews

  validates :name, :cuisine, :address, :city, :state, :zip, :owner, presence: true

  def average_rating
    reviews = self.reviews
    num_reviews = reviews.length
    sum_reviews = 0.0

    for review in reviews
      sum_reviews += review.value
    end
    average = sum_reviews / num_reviews
    average.round(1)
  end
end
