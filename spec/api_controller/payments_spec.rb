require 'rails_helper'

RSpec.describe Api::PaymentsController, type: :request do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}
    
    let!(:product) {create(:product,user:user)}
    let(:rental) {create(:rental_history,product:product,renter:renter)}
    let(:payment) {create(:payment_history)}
    let!(:renter_account_token) { create(:doorkeeper_access_token , resource_owner_id: renter_account.id)}
    let!(:user_account_token) { create(:doorkeeper_access_token , resource_owner_id: user_account.id)}

    
    describe "get /payments#create" do
        context "when renter is not signed in" do
            before do
                post "/api/payment1"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                post "/api/payment1", params: {access_token: renter_account_token.token,rental_id:"id",cardnumber:payment.cardnumber, cvc:payment.cvc, expiry:payment.expiry,amount:payment.amount}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

        context "when renter is signed in" do
            before do
                post "/api/payment1", params: {access_token: renter_account_token.token,rental_id:rental.id,cardnumber:payment.cardnumber, cvc:payment.cvc, expiry:payment.expiry,amount:payment.amount}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when user is signed in" do
            before do
                post "/api/payment1", params: {access_token: user_account_token.token,rental_id:rental.id,cardnumber:payment.cardnumber, cvc:payment.cvc, expiry:payment.expiry,amount:payment.amount}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
    end


    describe "get /payments#show" do
        context "when renter is not signed in" do
            before do
                get "/api/paymenthistory"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
        
        context "when user is signed in" do
            before do
                get "/api/paymenthistory", params: {access_token: user_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in" do
            before do
                get "/api/paymenthistory", params: {access_token: renter_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

    end

    describe "get /payments#showproduct" do
        context "when renter is not signed in" do
            before do
                get "/api/paymenthistories/#{product.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
        
        context "when user is signed in" do
            before do
                get "/api/paymenthistories/#{product.id}", params: {access_token: user_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in" do
            before do
                get "/api/paymenthistories/#{product.id}", params: {access_token: renter_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                get "/api/paymenthistories/#{"q"}", params: {access_token: renter_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

    end

    describe "get /payments#producthistory" do
        context "when user is not signed in" do
            before do
                get "/api/producthistory/#{product.id}"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end
        
        context "when user is signed in" do
            before do
                get "/api/producthistory/#{product.id}", params: {access_token: user_account_token.token}
            end
            it "returns status 200" do
              expect(response).to have_http_status(200)
            end
        end

        context "when renter is signed in" do
            before do
                get "/api/producthistory/#{product.id}", params: {access_token: renter_account_token.token}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when user is signed in and uses invalid params" do
            before do
                get "/api/producthistory/#{"q"}", params: {access_token: user_account_token.token}
            end
            it "returns status 404" do
              expect(response).to have_http_status(404)
            end
        end

    end


end
