class Rating < ApplicationRecord
    belongs_to :ratable, polymorphic: true
end
