require 'rails_helper'

RSpec.describe Renter, type: :model do
  describe "association" do
    context "has_many" do
      [:products , :rental_histories , :ratings].each do |each|
        it each.to_s.humanize do
          association = Renter.reflect_on_association(each).macro
          expect(association).to be(:has_many)
        end
      end
    end

    context "has_one" do
      it :account.to_s.humanize do
        association = Renter.reflect_on_association(:account).macro
        expect(association).to be(:has_one)
      end
    end

  end

  describe "aadhar" do

    before(:each) do
      renter.validate
    end

    context "if value is present" do
      let(:renter) {build(:renter,aadhar:"1234567890")}
      it "doesn't throw any error" do
        expect(renter.errors).to_not include(:aadhar)
      end
    end

    context "if value is not present" do
      let(:renter) {build(:renter,aadhar:nil)}
      it "throws an error" do
        expect(renter.errors).to include(:aadhar)
      end
    end

    context "if value is present" do
      let(:renter) {build(:renter,aadhar:"")}
      it "throws an error" do
        expect(renter.errors).to include(:aadhar)
      end
    end

  end
end
