require 'rails_helper'

RSpec.describe Api::MainController, type: :request do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}
    
    let!(:product) {create(:product,user:user)}
    
    let!(:renter_account_token) { create(:doorkeeper_access_token , resource_owner_id: renter_account.id)}
    let!(:user_account_token) { create(:doorkeeper_access_token , resource_owner_id: user_account.id)}


    describe "get main#index" do
        context "when renter is not signed in" do
            before do
                get "/api/renter"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when user is signed in" do
            before do
                get "/api/renter", params: {access_token: user_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
        
        context "when user is signed in" do
            before do
                get "/api/renter", params: {access_token: renter_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end
    end

    describe "get main#show" do
        context "when renter is not signed in" do
            before do
                get "/api/showproduct/#{product.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in" do
            before do
                get "/api/showproduct/#{product.id}", params: {access_token: renter_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when user is signed in" do
             before do
                get "/api/showproduct/#{product.id}", params: {access_token: user_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in and uses invalid params" do
             before do
                get "/api/showproduct/#{"q"}", params: {access_token: renter_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end
    end
end