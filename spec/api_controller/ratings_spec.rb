require 'rails_helper'

RSpec.describe Api::RatingsController, type: :request do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}
    
    let!(:product) {create(:product,user:user)}
    let!(:renter_account_token) { create(:doorkeeper_access_token , resource_owner_id: renter_account.id)}
    let!(:user_account_token) { create(:doorkeeper_access_token , resource_owner_id: user_account.id)}

    describe "get /ratings#createproduct" do
        context "when renter is not signed in" do
            before do
                post "/api/ratings", params: {comment:"good",rating:4,product_id:product.id}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
        context "when renter is signed in and params is invalid" do
            before do
                post "/api/ratings", params: {access_token: renter_account_token.token,comment:"good",rating:4,product_id:"p"}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user is signed in" do
            before do
                post "/api/ratings", params: {access_token: user_account_token.token,comment:"good",rating:4,product_id:product.id}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in" do
            before do
                post "/api/ratings", params: {access_token: renter_account_token.token,comment:"good",rating:4,product_id:product.id}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

    end

    describe "get /ratings#createuser" do
        context "when user is not signed in" do
            before do
                post "/api/rratings", params: {comment:"good",rating:4,renter_id:renter.id}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
        context "when user is signed in and params is invalid" do
            before do
                post "/api/rratings", params: {access_token: user_account_token.token,comment:"good",rating:4,renter_id:"r"}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user is signed in" do
            before do
                post "/api/rratings", params: {access_token: user_account_token.token,comment:"good",rating:4,renter_id:renter.id}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when renter is signed in" do
            before do
                post "/api/rratings", params: {access_token: renter_account_token.token,comment:"good",rating:4,renter_id:renter.id}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

    end
    
      
end