require 'rails_helper'

RSpec.describe Account, type: :model do

  describe 'association' do

    context "belongs_to" do
      let!(:account) {create(:account , :for_user)}
      it "user is true" do
        expect(account.accountable).to be_an_instance_of(User)
      end
    end

    context "belongs_to" do
      let!(:account) {create(:account , :for_renter)}
      it "renter is true" do
        expect(account.accountable).to be_an_instance_of(Renter)
      end
    end



  end



  describe "name" do
    before(:each) do
      account.validate
    end

    context "when name is present" do
      let(:account) {build(:account,name:"naren")}
      it "doesn't throw any error" do
        expect(account.errors).to_not include(:name)
      end
    end

    context "when name is not present" do
      let(:account) {build(:account,name:nil)}
      it "throws an error" do
        expect(account.errors).to include(:name)
      end
    end

    context "when name is empty" do
      let(:account) {build(:account,name:"")}
      it "throws an error" do
        expect(account.errors).to include(:name)
      end
    end

    context "when name length is less than 5" do
      let(:account) {build(:account,name:"nare")}
      it "throws an error" do
        expect(account.errors).to include(:name)
      end
    end

    context "when name length is greater than 20" do
      let(:account) {build(:account,name:"narendranathkannusamy")}
      it "throws an error" do
        expect(account.errors).to include(:name)
      end
    end
  end


  describe "email" do

    before(:each) do
      account.validate
    end


    context "when email is present" do
      let(:account) {build(:account,email:"narendranath2445@gmail.com")}
      it "doesn't throw any error" do
        expect(account.errors).to_not include(:email)
      end
    end

    context "when email is not present" do
      let(:account) {build(:account,email:nil)}
      it "throws an error" do
        expect(account.errors).to include(:email)
      end
    end

    context "when email is empty" do
      let(:account) {build(:account,email:"")}
      it "throws an error" do
        expect(account.errors).to include(:email)
      end
    end

    context "when it is not an email" do
      let(:account) {build(:account,email:"naren")}
      it "throws an error" do
        expect(account.errors).to include(:email)
      end
    end


  end
end
