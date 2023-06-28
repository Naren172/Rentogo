require 'rails_helper'

RSpec.describe Api::ProductsController, type: :request do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:user1) {create(:user)}
    let(:user_account1) {create(:account,:for_user, accountable: user1)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}
    
    let!(:product) {create(:product,user:user)}
    let!(:renter_account_token) { create(:doorkeeper_access_token , resource_owner_id: renter_account.id)}
    let!(:user_account_token) { create(:doorkeeper_access_token , resource_owner_id: user_account.id)}
    let!(:user_account_token1) { create(:doorkeeper_access_token , resource_owner_id: user_account1.id)}


    describe "get /products#index" do
        context "when user not signed in" do
            before do
                get "/api/products"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when user_account is signed in" do
            before do
                get "/api/products", params: {access_token: user_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when renter_account is signed in" do
            before do
                get "/api/products", params: {access_token: renter_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
    end

    describe "get /products#show" do
        context "when user not signed in" do
            before do
                get "/api/products/#{product.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter_account is signed in" do
            before do
                get "/api/products/#{product.id}", params: {access_token: renter_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when user_account is signed in" do
            before do
                get "/api/products", params: {access_token: user_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end
    end


    describe "get /products#create" do
        context "when user not signed in" do
            before do
                post "/api/products", params:{name:product.name,rent:product.rent,description:product.description}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter_account is signed in" do
            before do
                post "/api/products", params:{product:{name:product.name,rent:product.rent,description:product.description}}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when user_account is signed in" do
            before do
                post "/api/products", params:{access_token: user_account_token.token,product:{name:product.name,rent:product.rent,description:product.description}}
            end
            it "returns status 422" do
              expect(response).to have_http_status(422)
            end
        end
    end

   
    describe "patch /products#update" do
        context "when user not signed in" do
            before do
                patch "/api/products/#{product.id}", params:{product:{name:product.name,rent:product.rent,description:product.description}}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter_account is signed in" do
            before do
                patch "/api/products/#{product.id}", params:{access_token: renter_account_token.token,product:{name:product.name,rent:product.rent,description:product.description}}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when usser_account is signed in as other user" do
            before do
                patch "/api/products/#{product.id}", params:{access_token: user_account_token1.token,product:{name:product.name,rent:product.rent,description:product.description}}
            end
            it "returns status 403" do
              expect(response).to have_http_status(403)
            end
        end

        context "when user_account is signed in with invalid params" do
            before do
                patch "/api/products/#{"a"}", params:{access_token: user_account_token.token,product:{name:product.name,rent:product.rent,description:product.description}}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when user_account is signed in" do
            before do
                patch "/api/products/#{product.id}", params:{access_token: user_account_token.token,product:{name:product.name,rent:product.rent,description:product.description}}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

    end

    describe "delete /products#destroy" do
        context "when user not signed in" do
            before do
                delete "/api/products/#{product.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter_account is signed in" do
            before do
                delete "/api/products/#{product.id}",params:{access_token: renter_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when user_account is signed in with invalid params" do
            before do
                delete "/api/products/#{"a"}",params:{access_token: user_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

         context "when user_account is signed in as another owner" do
            before do
                delete "/api/products/#{product.id}",params:{access_token: user_account_token1.token}
            end
            it "returns status 403" do
              expect(response).to have_http_status(403)
            end
        end

        context "when user_account is signed in" do
            before do
                delete "/api/products/#{product.id}",params:{access_token: user_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

    end
    

   
end
