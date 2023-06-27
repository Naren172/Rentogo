require 'rails_helper'

RSpec.describe ApplicantsController, type: :controller do
    let(:user) {create(:user)}
    let(:user_account) {create(:account,:for_user, accountable: user)}

    let(:renter) {create(:renter)}
    let(:renter_account) {create(:account,:for_renter, accountable: renter)}

    let!(:product) {create(:product,user:user)}
    let!(:applicant) {create(:applicant,product:product,renter_id:renter.id)}

    describe "get applicants#new" do
        context "when renter is not signed in" do
            before do
                get :new,params:{id:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :new,params:{id:product.id}
            end
            it "redirects to renter page" do
                expect(response).to redirect_to(renter_path)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                sign_in renter_account
                get :new,params:{id:"id"}
            end
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                get :new,params:{id:product.id}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end
    end

    describe "get applicants#show" do
        context "when renter is not signed in" do
            before do
                get :show,params:{id:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :show,params:{id:product.id}
            end
            it "redirects to the template" do
                expect(response).to render_template(:show)
            end
        end

        context "when renter is signed in and uses invalid params" do
            before do
                sign_in renter_account
                get :show,params:{id:"id"}
            end
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end

        context "when user is signed in" do
            before do
                sign_in user_account
                get :show,params:{id:product.id}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end
    end

    describe "get applicants#index" do
        context "when user is signed in" do
            before do
                sign_in user_account
                get :index
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when renter is not signed in" do
            before do
                get :index
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :index
            end
            it "redirects to the template" do
                expect(response).to render_template(:index)
            end
        end
    end

    describe "get applicants#view" do
        context "when user is signed in" do
            before do
                sign_in user_account
                get :view, params:{id:product.id}
            end
            it "redirects to the template" do
                expect(response).to render_template(:view)
            end
        end

        context "when user is signed in and uses invalid parames" do
            before do
                sign_in user_account
                get :view, params:{id:"id"}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when user is not signed in" do
            before do
                get :view, params:{id:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :view, params:{id:product.id}
            end
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end
    end

    describe "get applicants#accept" do
        context "when user is signed in" do
            before do
                sign_in user_account
                get :accept, params:{renterid:renter.id,productid:product.id}
            end
            it "redirects to add page" do
                expect(response).to redirect_to(add_path(productid:product.id,renterid:renter.id))
            end
        end

        context "when user is signed in and uses invalid params" do
            before do
                sign_in user_account
                get :accept, params:{renterid:"id",productid:product.id}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when user is signed in and uses invalid params" do
            before do
                sign_in user_account
                get :accept, params:{renterid:renter.id,productid:"id"}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when user is not signed in" do
            before do
                get :accept, params:{renterid:renter.id,productid:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :accept, params:{renterid:renter.id,productid:product.id}
            end
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end
    end

    describe "get applicants#reject" do
        context "when user is signed in" do
            before do
                sign_in user_account
                get :reject, params:{renterid:renter.id,productid:product.id}
            end
            it "redirects to add page" do
                expect(response).to redirect_to(view_path(product))
            end
        end

        context "when user is signed in and uses invalid params" do
            before do
                sign_in user_account
                get :reject, params:{renterid:"id",productid:product.id}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when user is signed in and uses invalid params" do
            before do
                sign_in user_account
                get :reject, params:{renterid:renter.id,productid:"id"}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end

        context "when user is not signed in" do
            before do
                get :reject, params:{renterid:renter.id,productid:product.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end

        context "when renter is signed in" do
            before do
                sign_in renter_account
                get :reject, params:{renterid:renter.id,productid:product.id}
            end
            it "redirects to renter index page" do
                  expect(response).to redirect_to(renterindex_path)
            end
        end
    end

    describe "delete /applicants#destroy" do
        context "when renter is not signed in" do
            before do
                delete :destroy, params:{id:applicant.id}
            end
            it "redirects to sign in page" do
                expect(response).to redirect_to(new_account_session_path)
            end
        end
        context "when renter is signed in" do
            before do
                sign_in renter_account
                delete :destroy, params:{id:applicant.id}
            end
            it "redirects to applicants page" do
                expect(response).to redirect_to(applications_path)
            end
        end
        context "when renter is signed in and uses invalid params" do
            before do
                sign_in renter_account
                delete :destroy, params:{id:"id"}
            end
            it "redirects to renter index page" do
                expect(response).to redirect_to(renterindex_path)
            end
        end
        context "when user is signed in" do
            before do
                sign_in user_account
                delete :destroy, params:{id:applicant.id}
            end
            it "redirects to owner page" do
                expect(response).to redirect_to(owner_path)
            end
        end
    end

end