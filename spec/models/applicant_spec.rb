require 'rails_helper'

RSpec.describe Applicant, type: :model do


  describe 'association' do

    context "belongs_to"  do
      let(:product) {create(:product)}
      let(:applicant) {build(:applicant , product:product)}
      
      it "product is true" do
        expect(applicant.product).to be_an_instance_of(Product)
      end
    end
  end



  describe "status" do

    before(:each) do
      applicant.validate
    end
    context "when status is present" do
      let(:applicant) {build(:applicant,status:"Applied")}
      it "doesn't throw any error" do
        expect(applicant.errors).to_not include(:status)
      end
    end

    context "when status is not present" do
      let(:applicant) {build(:applicant,status:nil)}
      it "throws an error" do
        expect(applicant.errors).to include(:status)
      end
    end

    context "when status is empty" do
      let(:applicant) {build(:applicant,status:"")}
      it "throws an error" do
        expect(applicant.errors).to include(:status)
      end
    end
   end


  

end
