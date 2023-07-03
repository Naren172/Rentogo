require 'rails_helper'

RSpec.describe Delivery, type: :model do
  describe 'association' do
    context "belongs_to"  do
      let(:payment_history) {create(:payment_history)}
      let(:delivery) {build(:delivery , payment_history:payment_history)}
      it "product is true" do
        expect(delivery.payment_history).to be_an_instance_of(PaymentHistory)
      end
    end

    context "belongs_to"  do
      let(:rental_history) {create(:rental_history)}
      let(:delivery) {build(:delivery ,rental_history:rental_history)}
      it "product is true" do
        expect(delivery.rental_history).to be_an_instance_of(RentalHistory)
      end
    end
  end

  describe "location" do
    before(:each) do
      delivery.validate
    end
    context "when location is present" do
      let(:delivery) {build(:delivery,location:"erode")}
      it "doesn't throw any error" do
        expect(delivery.errors).to_not include(:location)
      end
    end

    context "when location is not present" do
      let(:delivery) {build(:delivery,location:nil)}
      it "throws an error" do
        expect(delivery.errors).to include(:location)
      end
    end

    context "when location is empty" do
      let(:delivery) {build(:delivery,location:"")}
      it "throws an error" do
        expect(delivery.errors).to include(:location)
      end
    end
  end
end
