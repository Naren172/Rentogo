require 'rails_helper'

RSpec.describe PaymentHistory, type: :model do

  describe "association" do
    context "has_one" do

      # [:delivery].each do |each|
        it :delivery.to_s.humanize do
          association = PaymentHistory.reflect_on_association(:delivery).macro
          expect(association).to be(:has_one)
        end
      end
    # end
  end

  describe "cardnumber" do

    before(:each) do
      payment_history.validate
    end

    context "if value is present" do
      let(:payment_history) {build(:payment_history,cardnumber:"1234567890")}
      it "doesn't throw any error" do
        expect(payment_history.errors).to_not include(:cardnumber)
      end
    end

     context "if value is not present" do
      let(:payment_history) {build(:payment_history,cardnumber:nil)}
      it "throws an error" do
        expect(payment_history.errors).to include(:cardnumber)
      end
    end

    context "if value is empty" do
      let(:payment_history) {build(:payment_history,cardnumber:"")}
      it "throws an error" do
        expect(payment_history.errors).to include(:cardnumber)
      end
    end

  end

  describe "cvc" do
    before(:each) do
      payment_history.validate
    end

    context "if value is present" do
      let(:payment_history) {build(:payment_history,cvc:"890")}
      it "doesn't throw any error" do
        expect(payment_history.errors).to_not include(:cvc)
      end
    end

    context "if value is not present" do
      let(:payment_history) {build(:payment_history,cvc:nil)}
      it "throws an error" do
        expect(payment_history.errors).to include(:cvc)
      end
    end

    context "if value is empty" do
      let(:payment_history) {build(:payment_history,cvc:"")}
      it "throws an error" do
        expect(payment_history.errors).to include(:cvc)
      end
    end
  end

  describe "amount" do
     before(:each) do
      payment_history.validate
    end

    context "when amount is present" do
      let(:payment_history) {create(:payment_history,amount:2000)}
      it "doesn't throw any error" do
        expect(payment_history.errors).to_not include(:amount)
      end
    end
   

    context "when amount is not present" do
      let(:payment_history) {build(:payment_history , amount: nil)}
      it "throws an error" do
        expect(payment_history.errors).to include(:amount)
      end
    end

    context "when amount is empty" do
      let(:payment_history) {build(:payment_history , amount: "")}
      it "throws an error" do
        expect(payment_history.errors).to include(:amount)
      end
    end

    context "when amount is less than 50" do
      let(:payment_history) {build(:payment_history , amount: 20)}
      it "throws an error" do
        expect(payment_history.errors).to include(:amount)
      end
    end

    context "when amount is float" do
      let(:payment_history) {build(:payment_history , amount: 250.55)}
      it "throws an error" do
        expect(payment_history.errors).to include(:amount)
      end
    end

     context "when value is alphabetic" do
      let(:payment_history) {build(:payment_history , amount: "abcde")}
      it "throws an error" do
        expect(payment_history.errors).to include(:amount)
      end
    end

    context "when value is alpha-numeric" do
      let(:payment_history) {build(:payment_history ,amount: "ab123")}
      it "throws an error" do
        expect(payment_history.errors).to include(:amount)
      end
    end

    context "when value is negative" do
      let(:payment_history) {build(:payment_history , amount: -123)}
      it "throws an error" do
        expect(payment_history.errors).to include(:amount)
      end
    end
  end

  describe "expiry" do
    before(:each) do
      payment_history.validate
    end

    context "if value is present" do
      let(:payment_history) {build(:payment_history, expiry:"Wed, 21 Jun 2023")}
      it "doesn't throw any error" do
        expect(payment_history.errors).to_not include(:expiry)
      end
    end

    context "if value is not in date format" do
      let(:payment_history) {build(:payment_history, expiry:"Wed,Jun 2023")}
      it "throws an error" do
        expect(payment_history.errors).to include(:expiry)
      end
    end

    context "if value is not present" do
      let(:payment_history) {build(:payment_history, expiry:nil)}
      it "throws an error" do
        expect(payment_history.errors).to include(:expiry)
      end
    end
    
    context "if value is empty" do
      let(:payment_history) {build(:payment_history, expiry:"")}
      it "throws an error" do
        expect(payment_history.errors).to include(:expiry)
      end
    end


  end


end
