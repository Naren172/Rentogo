require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}
    
    let!(:product) {create(:product,user:user)}

    describe "get /ratings#newproduct" do
        context "when renter is not signed in" do
            before do
                get :newproduct, params:{id:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end
        context "when renter is signed in and params is invalid" do
            before do
                sign_in renter_account
                get :newproduct, params:{id:"id"}
            end
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                get :newproduct, params:{id:product.id}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :newproduct, params:{id:product.id}
            end
            it "redirects o the template" do
                expect(response).to render_template(:newproduct)
            end
        end

    end

    describe "get /ratings#createproduct" do
        context "when renter is not signed in" do
            before do
                post :createproduct, params:{product_id:product.id,comment:"Good", rating:4}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end
        context "when renter is signed in and params is invalid" do
            before do
                sign_in renter_account
                post :createproduct, params:{product_id:"id",comment:"Good", rating:4}
            end
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                post :createproduct, params:{product_id:product.id,comment:"Good", rating:4}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                post :createproduct, params:{product_id:product.id,comment:"Good", rating:4}
            end
            it "redirects to renter show page" do
                expect(response).to redirect_to(rentershow_path)
            end
        end

    end

    describe "get /ratings#newrenter" do
        context "when user is not signed in" do
            before do
                get :newrenter, params:{id:renter.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end
        context "when user is signed in and params is invalid" do
            before do
                sign_in user_account
                get :newrenter, params:{id:"id"}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :newrenter, params:{id:renter.id}
            end
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                get :newrenter, params:{id:renter.id}
            end
            it "redirects to the template page" do
                expect(response).to render_template(:newrenter)
            end
        end

    end

    describe "get /ratings#createuser" do
        context "when renter is not signed in" do
            before do
                post :createuser, params:{renter_id:renter.id,comment:"Good", rating:4}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end
        context "when user is signed in and params is invalid" do
            before do
                sign_in user_account
                post :createuser, params:{renter_id:"id",comment:"Good", rating:4}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                post :createuser, params:{renter_id:renter.id,comment:"Good", rating:4}
            end
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                post :createuser, params:{renter_id:renter.id,comment:"Good", rating:4}
            end
            it "redirects to products page" do
                expect(response).to redirect_to(products_path)
            end
        end

    end
        
      
end