require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}
    
    let!(:product) {create(:product,user:user)}
    let(:rental) {create(:rental_history,product:product,renter:renter)}
    let(:payment) {create(:payment_history)}

    describe "get /payments#new" do
        context "when renter is not signed in" do
            before do
                get :new, params:{product:product.id, rental:rental.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end
        
        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :new, params:{product:product.id, rental:rental.id}
            end
            it "redirects to the template" do
                expect(response).to render_template(:new)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                get :new, params:{product:product.id, rental:rental.id}
            end
            it "redirects to the template" do
                expect(response).to redirect_to(owner_path)
            end
        end
        
    
        context "when renter is signed in and uses invalid params" do
            before do
                sign_in renter_account
                get :new, params:{product:"id", rental:rental.id}
            end
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end
        
   
        context "when renter is signed in and uses invalid params" do
            before do
                sign_in renter_account
                get :new, params:{product:product.id, rental:"id"}
            end
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end
        
    end
    describe "get /payments#create" do
        context "when renter is not signed in" do
            before do
                post :create, params:{rental_id:rental.id,cardnumber:payment.cardnumber, cvc:payment.cvc, expiry:payment.expiry,amount:payment.amount}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                sign_in renter_account
                post :create, params:{rental_id:"id",cardnumber:payment.cardnumber, cvc:payment.cvc, expiry:payment.expiry,amount:payment.amount}
            end
            it "redirects to delivery page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                post :create, params:{rental_id:rental.id,cardnumber:payment.cardnumber, cvc:payment.cvc, expiry:payment.expiry,amount:payment.amount}
            end
            it "redirects to delivery page" do
                expect(response).to redirect_to(delivery_path(paymentid:payment.id+1,rentalid:rental.id))
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                post :create, params:{rental_id:rental.id,cardnumber:payment.cardnumber, cvc:payment.cvc, expiry:payment.expiry,amount:payment.amount}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end
    end


    describe "get /payments#show" do
        context "when renter is not signed in" do
            before do
                get :show
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end
        
        context "when user is signed in" do
            before do
                sign_in user_account
                get :show
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :show
            end
            it "redirects to owner page" do
                expect(response).to render_template(:show)
            end
        end

    end

    describe "get /payments#showproduct" do
        context "when renter is not signed in" do
            before do
                get :showproduct, params:{id:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end
        
        context "when user is signed in" do
            before do
                sign_in user_account
                get :showproduct, params:{id:product.id}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :showproduct, params:{id:product.id}
            end
            it "redirects to owner page" do
                expect(response).to render_template(:showproduct)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                sign_in renter_account
                get :showproduct, params:{id:"q"}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

    end

    describe "get /payments#producthistory" do
        context "when renter is not signed in" do
            before do
                get :producthistory, params:{id:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end
        
        context "when user is signed in" do
            before do
                sign_in user_account
                get :producthistory, params:{id:product.id}
            end
            it "redirects to the template" do
                expect(response).to render_template(:producthistory)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :producthistory, params:{id:product.id}
            end
            it "redirects to renter page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user is signed in and uses invalid params" do
            before do
                sign_in user_account
                get :producthistory, params:{id:"q"}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

    end


end
