class Applicant < ApplicationRecord
    belongs_to :product



    scope :accepted, -> {Applicant.where("status=?","Accepted")}
    scope :rejected, -> {Applicant.where("status=?","Rejected")}

end
