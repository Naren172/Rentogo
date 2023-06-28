require 'rails_helper'

RSpec.describe MainController, type: :controller do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}
    
    let!(:product) {create(:product,user:user)}
   
    describe "get main#index" do
        context "when renter is not signed in" do
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

    describe "get main#show" do
        context "when renter is not signed in" do
            before do
                get :show, params:{id:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :show, params:{id:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to render_template(:show)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                get :show, params:{id:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                sign_in renter_account
                get :show, params:{id:"id"}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end
    end
end