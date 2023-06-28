require 'rails_helper'

RSpec.describe Api::RentalController, type: :request do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}

    let!(:product) {create(:product,user:user)}

    let(:rental_history) {create(:rental_history,renter:renter, product:product)}
    let!(:renter_account_token) { create(:doorkeeper_access_token , resource_owner_id: renter_account.id)}
    let!(:user_account_token) { create(:doorkeeper_access_token , resource_owner_id: user_account.id)}

    describe "get /rentals#new" do
        context "when user not signed in" do
            before do
                get "/api/add/#{product.id}/#{renter.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when user is signed in with invalid params" do
            before do
                get "/api/add/#{"id"}/#{renter.id}",params: {access_token: user_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user is signed in with invalid params" do
            before do
                get "/api/add/#{product.id}/#{"id"}",params: {access_token: user_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user is signed in with valid params" do
            before do
                get "/api/add/#{product.id}/#{renter.id}",params: {access_token: user_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

    end

    describe "get /rentals#index" do
        context "when renter not signed in" do
            before do
                get "/api/rentershow/"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
        
        context "when user is signed in" do
            before do
                get "/api/rentershow/",params: {access_token: user_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when user is signed in" do
            before do
                get "/api/rentershow/",params: {access_token: renter_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end
    end
end