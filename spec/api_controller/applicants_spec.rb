require 'rails_helper'

RSpec.describe Api::ApplicantsController, type: :request do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}

    let!(:product) {create(:product,user:user)}
    let!(:applicant) {create(:applicant,product:product,renter_id:renter.id)}

    let!(:renter_account_token) { create(:doorkeeper_access_token , resource_owner_id: renter_account.id)}
    let!(:user_account_token) { create(:doorkeeper_access_token , resource_owner_id: user_account.id)}

    describe "get applicants#new" do
        context "when renter is not signed in" do
            before do
                get "/api/apply/#{product.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
    
        context "when renter is signed in" do
            before do
                get "/api/apply/#{product.id}", params: {access_token: renter_account_token.token}
            end
            it "returns status 201" do
              expect(response).to have_http_status(201)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                
                get "/api/apply/#{"id"}", params: {access_token: renter_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user is signed in" do
            before do
                get "/api/apply/#{product.id}", params: {access_token: user_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
    end

    describe "get applicants#show" do
        context "when renter is not signed in" do
            before do
                get "/api/applications/#{product.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in" do
            before do
                get "/api/applications/#{product.id}", params: {access_token: renter_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                get "/api/applications/#{"id"}", params: {access_token: renter_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user is signed in" do
            before do
                get "/api/applications/#{product.id}", params: {access_token: user_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
    end

    describe "get applicants#index" do
        context "when user is signed in" do
            before do
                get "/api/applications", params: {access_token: user_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is not signed in" do
            before do
                get "/api/applications"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in" do
            before do
                get "/api/applications", params: {access_token: renter_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end
    end

    describe "get applicants#view" do
        context "when user is signed in" do
            before do
                get "/api/view/#{product.id}", params: {access_token: user_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when user is signed in and uses invalid parames" do
            before do
                get "/api/view/#{"id"}", params: {access_token: user_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user is not signed in" do
            before do
                get "/api/view/#{product.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in" do
            before do
                get "/api/view/#{product.id}" , params: {access_token: renter_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
    end

    describe "get applicants#accept" do
        context "when user is signed in" do
            before do
                get "/api/accept/#{renter.id},#{product.id}", params: {access_token: user_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when user is signed in and uses invalid params" do
            before do
                get "/api/accept/#{"id"},#{product.id}", params: {access_token: user_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user is signed in and uses invalid params" do
            before do
                get "/api/accept/#{renter.id},#{"id"}", params: {access_token: user_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user is not signed in" do
            before do
                get "/api/accept/#{renter.id},#{product.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in" do
            before do
                get "/api/accept/#{renter.id},#{product.id}", params: {access_token: renter_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
    end

    describe "get applicants#reject" do
        context "when user is signed in" do
            before do
                get "/api/reject/#{renter.id},#{product.id}", params: {access_token: user_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when user is signed in and uses invalid params" do
            before do
                get "/api/reject/#{"id"},#{product.id}", params: {access_token: user_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user is signed in and uses invalid params" do
           before do
                get "/api/reject/#{renter.id},#{"id"}", params: {access_token: user_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user is not signed in" do
            before do
                get "/api/reject/#{renter.id},#{product.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in" do
            before do
                get "/api/reject/#{renter.id},#{product.id}", params: {access_token: renter_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
    end

    describe "delete /applicants#destroy" do
        context "when renter is not signed in" do
            before do
                delete "/api/delete/#{applicant.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
        context "when renter is signed in" do
            before do
                delete "/api/delete/#{applicant.id}", params: {access_token: renter_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end
        context "when renter is signed in and uses invalid params" do
            before do
                delete "/api/delete/#{"id"}", params: {access_token: renter_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end
        context "when user is signed in" do
            before do
                delete "/api/delete/#{applicant.id}", params: {access_token: user_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
    end

end
