require 'rails_helper'

RSpec.describe RentalHistory, type: :model do
  describe "association" do

    context "belongs_to" do
      let(:renter) {create(:renter)}
      let(:rental_history) {build(:rental_history,renter:renter)}
      it "user is true" do
        expect(rental_history.renter).to be_an_instance_of(Renter)
      end
    end

    context "belongs_to" do
      let(:product) {create(:product)}
      let(:rental_history) {build(:rental_history,product:product)}
      it "user is true" do
        expect(rental_history.product).to be_an_instance_of(Product)
      end
    end

    context "has_one" do

      [:delivery , :payment_history].each do |each|
        it each.to_s.humanize do
          association = RentalHistory.reflect_on_association(each).macro
          expect(association).to be(:has_one)
        end
      end
    end
    
  end


end
