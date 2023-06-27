require 'rails_helper'

RSpec.describe RentalController, type: :controller do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    
    let!(:product) {create(:product,user:user)}

    let(:rental_history) {create(:rental_history,renter:renter, product:product)}

    describe "get /rentals#new" do
        context "when user not signed in" do
            before do  
                get :new, params:{productid:product.id, renterid:renter.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when user is signed in with invalid params" do
            before do  
                sign_in user_account
                get :new, params:{productid:"id", renterid:renter.id}
            end
            it "redirects to owner index page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when user is signed in with invalid params" do
            before do  
                sign_in user_account
                get :new, params:{productid:product.id, renterid:"id"}
            end
            it "redirects to owner index page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when user is signed in with valid params" do
            before do  
                sign_in user_account
                get :new, params:{productid:product.id, renterid:renter.id}
            end
            it "redirects to products page" do
                expect(response).to redirect_to(products_path)
            end
        end

    end

    describe "get /rentals#index" do
        context "when renter not signed in" do
            before do  
                get :index
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        
        
        context "when user is signed in" do
            before do  
                sign_in user_account
                get :index
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        
    end
end