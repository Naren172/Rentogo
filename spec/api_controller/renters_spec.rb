require 'rails_helper'

RSpec.describe Api::RentersController, type: :request do
    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}

    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}
    let!(:renter_account_token) { create(:doorkeeper_access_token , resource_owner_id: renter_account.id)}
    let!(:user_account_token) { create(:doorkeeper_access_token , resource_owner_id: user_account.id)}

    describe "get /renters#view" do
        context "when user not signed in" do
            before do
                get "/api/view-profile/#{renter.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter_account is signed in" do
            before do
                get "/api/view-profile/#{renter.id}",params: {access_token: renter_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when user_account is signed in" do
            before do
                get "/api/view-profile/#{renter.id}",params: {access_token: user_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when renter_account is signed in with invalid PARAMS" do
            before do
                get "/api/view-profile/#{"a"}",params: {access_token: user_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end


    end

    describe "get /renters#rating" do
        context "when user not signed in" do
            before do
                get "/api/renterrating/#{renter.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter_account is signed in" do
            before do
                get "/api/renterrating/#{renter.id}",params: {access_token: renter_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when user_account is signed in" do
            before do
                get "/api/renterrating/#{renter.id}",params: {access_token: user_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when user_account is signed in" do
            before do
                get "/api/renterrating/#{"a"}",params: {access_token: user_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

    end

end