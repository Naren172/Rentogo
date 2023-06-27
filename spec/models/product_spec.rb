require 'rails_helper'

RSpec.describe Product, type: :model do



  describe "association" do

    context "belongs_to" do
      let(:user) {create(:user)}
      let(:product) {build(:product,user:user)}
      it "user is true" do
        expect(product.user).to be_an_instance_of(User)
      end
    end

    context "has_many" do

      [:applicants , :rental_histories , :ratings].each do |each|
        it each.to_s.humanize do
          association = Product.reflect_on_association(each).macro
          expect(association).to be(:has_many)
        end
      end
    end

    
  end





  describe "rent" do

    before(:each) do
      product.validate
    end

    context "when rent is present" do
      let(:product) {create(:product,rent:2000)}
      it "doesn't throw any error" do
        expect(product.errors).to_not include(:rent)
      end
    end
   

    context "when rent is not present" do
      let(:product) {build(:product , rent: nil)}
      it "throws an error" do
        expect(product.errors).to include(:rent)
      end
    end

    context "when rent is not present" do
      let(:product) {build(:product , rent: "")}
      it "throws an error" do
        expect(product.errors).to include(:rent)
      end
    end

    context "when rent is less than 50" do
      let(:product) {build(:product , rent: 20)}
      it "throws an error" do
        expect(product.errors).to include(:rent)
      end
    end

    context "when rent is float" do
      let(:product) {build(:product , rent: 250.55)}
      it "throws an error" do
        expect(product.errors).to include(:rent)
      end
    end

     context "when value is alphabetic" do
      let(:product) {build(:product , rent: "abcde")}
      it "throws an error" do
        expect(product.errors).to include(:rent)
      end
    end

    context "when value is alpha-numeric" do
      let(:product) {build(:product , rent: "ab123")}
      it "throws an error" do
        expect(product.errors).to include(:rent)
      end
    end

    context "when value is negative" do
      let(:product) {build(:product , rent: -123)}
      it "throws an error" do
        expect(product.errors).to include(:rent)
      end
    end



  end


  describe "name" do

    before(:each) do
      product.validate
    end


    context "when name is present" do
      let(:product) {build(:product,name:"camera")}
      it "doesn't throw any error" do
        expect(product.errors).to_not include(:name)
      end
    end

    context "when name is not present" do
      let(:product) {build(:product,name:nil)}
      it "throws an error" do
        expect(product.errors).to include(:name)
      end
    end

    context "when name is empty" do
      let(:product) {build(:product,name:"")}
      it "throws an error" do
        expect(product.errors).to include(:name)
      end
    end

    context "when name size is less than 3" do
      let(:product) {build(:product,name:"ca")}
      it "throws an error" do
        expect(product.errors).to include(:name)
      end
    end

    context "when name size is more than 20" do
      let(:product) {build(:product,name:"Acer Nitro 5 12th Gen Intel Core Intel Core i5-12500H Processor")}
      it "throws an error" do
        expect(product.errors).to include(:name)
      end
    end

  end

  describe "status" do
    before(:each) do
      product.validate
    end

    context "when status is present" do
      let(:product) {build(:product,status:"Available")}
      it "doesn't throw any error" do
        expect(product.errors).to_not include(:status)
      end
    end

    context "when status is not present" do
      let(:product) {build(:product,status:nil)}
      it "throws an error" do
        expect(product.errors).to include(:status)
      end
    end

    context "when status is empty" do
      let(:product) {build(:product,status:"")}
      it "throws an error" do
        expect(product.errors).to include(:status)
      end
    end
  end

  describe "description" do
    before(:each) do 
      product.validate
    end

    context "when description is present" do
      let(:product) {build(:product,description:"Acer Nitro 5 12th Gen Intel Core Intel Core i5-12500H Processor 15.6-inch (39.62 cms) FHD 144 Hz Gaming Laptop")}
      it "doesn't throw any error" do
        expect(product.errors).to_not include(:description)
      end
    end

    context "when description is not present" do
      let!(:product) {build(:product)}
      it "throws an error" do
        expect(product.description).to be_truthy
      end
    end

    context "when description is empty" do
      let(:product) {build(:product,description:"")}
      it "throws an error" do
        expect(product.errors).to include(:description)
      end
    end

    context "when description size is less then 10" do
      let(:product) {build(:product,description:"camera")}
      it "throw an error" do
        expect(product.errors).to include(:description)
      end
    end

    context "when description size is greater then 150" do
      let(:product) {build(:product,description:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")}
      it "throws an error" do
        expect(product.errors).to include(:description)
      end
    end

  end
end
