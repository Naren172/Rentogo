require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:user1) {create(:user)}
    let(:user_account1) {create(:account,:for_user, accountable: user1)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}
    
    let!(:product) {create(:product,user:user)}

    describe "get /products#index" do
        context "when user not signed in" do
            before do  
                get :index
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter_account is signed in" do
            before do  
                sign_in renter_account
                get :index
            end                     
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user is signed in" do
            before do  
                sign_in user_account
                get :index
            end                     
            it "redirects to the template" do
                expect(response).to render_template(:index)
            end
        end
    end

    describe "get /products#show" do
        context "when user not signed in" do
            before do  
                get :show, params:{id:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter_account is signed in" do
            before do  
                sign_in renter_account
                get :show, params:{id:product.id}
            end                     
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when renter_account is signed in" do
            before do  
                sign_in user_account
                get :show, params:{id:product.id}
            end                     
            it "redirects to the template" do
                expect(response).to render_template(:show)
            end
        end
    end

    describe "get /products#new" do
        context "when user not signed in" do
            before do  
                get :new
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter_account is signed in" do
            before do  
                sign_in renter_account
                get :new
            end                     
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end
    end

    describe "get /products#create" do
        context "when user not signed in" do
            before do  
                post :create, params:{name:product.name,rent:product.rent,description:product.description}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter_account is signed in" do
            before do  
                sign_in renter_account
                get :create, params:{name:product.name,rent:product.rent,description:product.description}
            end                     
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end
    end

    describe "get /products#edit" do
        context "when user not signed in" do
            before do  
                get :edit, params:{id:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter_account is signed in" do
            before do  
                sign_in renter_account
                get :edit, params:{id:product.id}
            end                     
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user_account is signed in with invalid params" do
            before do  
                sign_in user_account
                get :edit, params:{id:"a"}
            end                     
            it "redirects to roducts page" do
                expect(response).to redirect_to(products_path)
            end
        end

    end

    describe "patch /products#update" do
        context "when user not signed in" do
            before do  
                patch :update, params:{id:product.id,name:product.name,rent:product.rent,description:product.description}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter_account is signed in" do
            before do  
                sign_in renter_account
                patch :update, params:{id:product.id,name:product.name,rent:product.rent,description:product.description}
            end                     
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when usser_account is signed in as other user" do
            before do  
                sign_in user_account1
                patch :update, params:{id:product.id,product:{name:product.name,rent:product.rent,description:product.description}}
            end                     
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when user_account is signed in with invalid params" do
            before do  
                sign_in user_account
                patch :update, params:{id:"a",product:{name:product.name,rent:product.rent,description:product.description}}
            end                     
            it "redirects to owner index page" do
                expect(response).to redirect_to(ownerindex_path)
            end
        end

        context "when user_account is signed in owner" do
            before do  
                sign_in user_account
                patch :update, params:{id:product,product:{name:product.name,rent:product.rent,description:product.description}}
            end                     
            it "redirects to product page" do
                expect(response).to redirect_to(product_path)
            end
        end

    end

    describe "delete /products#destroy" do
        context "when user not signed in" do
            before do  
                delete :destroy, params:{id:product.id,name:product.name,rent:product.rent,description:product.description}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter_account is signed in" do
            before do  
                sign_in renter_account
                delete :destroy, params:{id:product.id}
            end                     
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user_account is signed in with invalid params" do
            before do  
                sign_in user_account
                delete :destroy, params:{id:"bn"}
            end                     
            it "redirects to owner index page" do
                expect(response).to redirect_to(ownerindex_path)
            end
        end

         context "when user_account is signed in as another owner" do
            before do  
                sign_in user_account1
                delete :destroy, params:{id:product.id}
            end                     
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

    end
   
end
