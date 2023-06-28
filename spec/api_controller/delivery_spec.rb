require 'rails_helper'

RSpec.describe Api::DeliveryController, type: :request do

    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}

    let!(:product) {create(:product,user:user)}
    let(:rental) {create(:rental_history,product:product,renter:renter)}
    let(:payment) {create(:payment_history)}
    let(:delivery) {create(:delivery, payment_history:payment,rental_history:rental)}
    let!(:renter_account_token) { create(:doorkeeper_access_token , resource_owner_id: renter_account.id)}
    let!(:user_account_token) { create(:doorkeeper_access_token , resource_owner_id: user_account.id)}

    
    describe "get delivery#create" do
        context "when renter is not signed in" do
            before do
                post "/api/deliverys"
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when user is signed in" do
            before do
                post "/api/deliverys", params: {access_token: user_account_token.token,location:delivery.location,rental_id:rental.id,payment_id:payment.id}
            end
            it "returns status 401" do
              expect(response).to have_http_status(401)
            end
        end

        context "when renter is signed in" do
            before do
                post "/api/deliverys", params: {access_token: renter_account_token.token,location:delivery.location,rental_id:rental.id,payment_id:payment.id}
            end
            it "returns status 201" do
              expect(response).to have_http_status(201)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                post "/api/deliverys", params: {access_token: renter_account_token.token,location:delivery.location,rental_id:"q",payment_id:payment.id}
            end
            it "returns status 422" do
              expect(response).to have_http_status(422)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                post "/api/deliverys", params: {access_token: renter_account_token.token,location:delivery.location,rental_id:rental.id,payment_id:"id"}
            end
            it "returns status 422" do
              expect(response).to have_http_status(422)
            end
        end
    end

end