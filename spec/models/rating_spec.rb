require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'association' do

    context "belongs_to" do
      let!(:rating) {create(:rating , :for_product)}
      it "rider is true" do
        expect(rating.ratable).to be_an_instance_of(Product)
      end
    end

    context "belongs_to" do
      let!(:rating) {create(:rating , :for_renter)}
      it "driver is true" do
        expect(rating.ratable).to be_an_instance_of(Renter)
      end
    end

    context "belongs_to" do
      let!(:rating) {create(:rating , :for_renter)}
      it "rider is true" do
        expect(rating.ratable).to_not be_an_instance_of(Product)
      end
    end

    context "belongs_to" do
      let!(:rating) {create(:rating , :for_product)}
      it "driver is true" do
        expect(rating.ratable).to_not be_an_instance_of(Renter)
      end
    end

  end

  describe "rating" do
    before(:each) do
      rating.validate
    end

    context "when rating is present" do
      let(:rating) {build(:rating, rating:2)}
      it "doesn't throw any error" do
        expect(rating.errors).to_not include(:rating)
      end
    end
   

    context "when rating is not present" do
      let(:rating) {build(:rating , rating: nil)}
      it "throws an error" do
        expect(rating.errors).to include(:rating)
      end
    end

    context "when rating is not present" do
      let(:rating) {build(:rating , rating: "")}
      it "throws an error" do
        expect(rating.errors).to include(:rating)
      end
    end

    context "when rating is less than 1" do
      let(:rating) {build(:rating , rating: 0.5)}
      it "throws an error" do
        expect(rating.errors).to include(:rating)
      end
    end

    context "when rating is greater than 5" do
      let(:rating) {build(:rating , rating: 6)}
      it "throws an error" do
        expect(rating.errors).to include(:rating)
      end
    end


     context "when value is alphabetic" do
      let(:rating) {build(:rating , rating: "abcde")}
      it "throws an error" do
        expect(rating.errors).to include(:rating)
      end
    end

    context "when value is alpha-numeric" do
      let(:rating) {build(:rating ,rating: "ab123")}
      it "throws an error" do
        expect(rating.errors).to include(:rating)
      end
    end

    context "when value is negative" do
      let(:rating) {build(:rating , rating: -123)}
      it "throws an error" do
        expect(rating.errors).to include(:rating)
      end
    end
  end

  describe "comment" do
    before(:each) do
      rating.validate
    end

    context "if value is present" do
      let(:rating) {build(:rating,comment:"good")}
      it "doesn't throw any error" do
        expect(rating.errors).to_not include(:comment)
      end
    end

    context "if value is not present" do
      let(:rating) {build(:rating,comment:nil)}
      it "throws an error" do
        expect(rating.errors).to include(:comment)
      end
    end

    context "if value is empty" do
      let(:rating) {build(:rating,comment:"")}
      it "throws an error" do
        expect(rating.errors).to include(:comment)
      end
    end

  end

end
