require 'rails_helper'

RSpec.describe User, type: :model do
  describe "association" do
     context "has_many" do
      [:products].each do |each|
        it each.to_s.humanize do
          association = User.reflect_on_association(each).macro
          expect(association).to be(:has_many)
        end
      end
    end

    context "has_one" do
      it :account.to_s.humanize do
        association = User.reflect_on_association(:account).macro
        expect(association).to be(:has_one)
      end
    end
  end

  describe "address" do
    before(:each) do
      user.validate
    end

    context "when value is present" do
      let(:user) {build(:user, address:"Erode")}
      it "doesn't throw any error" do
        expect(user.errors).to_not include(:address)
      end
    end

    context "when value is not present" do
      let(:user) {build(:user, address:nil)}
      it "doesn't throw any error" do
        expect(user.errors).to include(:address)
      end
    end

    context "when value is empty" do
      let(:user) {build(:user, address:"")}
      it "doesn't throw any error" do
        expect(user.errors).to include(:address)
      end
    end

  end

end
