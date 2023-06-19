class Rating < ApplicationRecord
    belongs_to :ratable, polymorphic: true
    validates :rating, :comment, presence: true
end
