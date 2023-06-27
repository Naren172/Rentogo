require 'rails_helper'

RSpec.describe DeliveryController, type: :controller do

    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}

    let!(:product) {create(:product,user:user)}
    let(:rental) {create(:rental_history,product:product,renter:renter)}
    let(:payment) {create(:payment_history)}
    let(:delivery) {create(:delivery, payment_history:payment,rental_history:rental)}
    
    describe "get delivery#new" do
        context "when renter is not signed in" do
            before do
                get :new,params:{paymentid:payment.id,rentalid:rental.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                get :new,params:{paymentid:payment.id,rentalid:rental.id}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :new,params:{paymentid:payment.id,rentalid:rental.id}
            end
            it "redirects to the template" do
                expect(response).to render_template(:new)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                sign_in renter_account
                get :new,params:{paymentid:"id",rentalid:rental.id}
            end
            it "redirects to renter page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                sign_in renter_account
                get :new,params:{paymentid:payment.id,rentalid:"id"}
            end
            it "redirects to renter page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end
    end

    describe "post delivery#create" do
        context "when renter is not signed in" do
            before do
                post :create, params:{location:delivery.location,rental_id:delivery.rental_history_id,payment_id:delivery.payment_history_id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                get :create, params:{location:delivery.location,rental_id:delivery.rental_history_id,payment_id:delivery.payment_history_id}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :create, params:{location:delivery.location,rental_id:delivery.rental_history_id,payment_id:delivery.payment_history_id}
            end
            it "redirects to renter show page" do
                expect(response).to redirect_to(rentershow_path)
            end
        end
    end
    
end