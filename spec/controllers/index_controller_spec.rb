require 'rails_helper'

RSpec.describe IndexController, type: :controller do

    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}
    
    describe "get index#renter" do
        context "when renter is not signed in" do
            before do
                get :renter
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                get :renter
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :renter
            end
            it "redirects to the template" do
                expect(response).to render_template(:renter)
            end
        end
    end

    describe "get index#owner" do
        context "when renter is not signed in" do
            before do
                get :owner
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                get :owner
            end
            it "redirects to the template" do
                expect(response).to render_template(:owner)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :owner
            end
            it "redirects to renter page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end
    end
    
end