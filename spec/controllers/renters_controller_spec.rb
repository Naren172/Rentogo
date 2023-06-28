require 'rails_helper'

RSpec.describe RentersController, type: :controller do
    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}

    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    describe "get /renters#view" do
        context "when user not signed in" do
            before do  
                get :view, params:{id:renter.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter_account is signed in" do
            before do  
                sign_in renter_account
                get :view, params:{id:renter.id}
            end                     
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user_account is signed in with invalid PARAMS" do
            before do  
                sign_in user_account
                get :view, params:{id:"A"}
            end                     
            it "redirects to owner index page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when user_account is signed in with invalid PARAMS" do
            before do  
                sign_in user_account
                get :view, params:{id:renter.id}
            end                     
            it "redirects to the template" do
                expect(response).to render_template(:view)
            end
        end


    end

    describe "get /renters#rating" do
        context "when user not signed in" do
            before do  
                get :rating, params:{id:renter.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter_account is signed in" do
            before do  
                sign_in renter_account
                get :rating, params:{id:renter.id}
            end                     
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user_account is signed in with invalid PARAMS" do
            before do  
                sign_in user_account
                get :rating, params:{id:"A"}
            end                     
            it "redirects to owner index page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when user_account is signed in" do
            before do  
                sign_in user_account
                get :rating, params:{id:renter.id}
            end                     
            it "redirects to the template" do
                expect(response).to render_template(:rating)
            end
        end

    end

end