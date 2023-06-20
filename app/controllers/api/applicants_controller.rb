class Api::ApplicantsController < Api::ApiController
    before_action :authenticate_account!
    before_action :is_renter? , except: [:accept,:reject,:view]
     def new
        applicant=Applicant.new
        applicant.status="Applied"
        account=current_account
        renter=Renter.find(current_account.accountable_id)
        applicant.renter_id=renter.id
        product=Product.find(params[:id])
        product.applicants<<applicant
        applicant.save
        product.save
        redirect_to renter_path 
    end

    def show
        @product=Product.find(params[:id])
    end

    def index
        renter=Renter.find(current_account.accountable_id)
        @applicants=Applicant.where(renter_id:renter.id)
    end

    def view       
        product=Product.find(params[:id])
        applicants=product.applicants
        @renter=[]
        applicants.each do |applicant|
            if(applicant.status!="Rejected")
                @renter<<Renter.find(applicant.renter_id)
            end
        # @applicants=Applicant.where(product_id:product.id)
        end
    end

    def accept
        applicant=Applicant.find_by(renter_id:params[:id])
        product=Product.find(applicant.product_id)
        unless product.user_id==current_account.accountable_id
            redirect_to owner_path
            return
        end
        applicants=Applicant.where(product_id:applicant.product_id)
        applicants.each do |app|
            app.status="Rejected"
            app.save
        end
        applicant.status="Accepted" 
        applicant.save
        product=Product.find(applicant.product_id)
        product.status="Unavailable"
        redirect_to add_path(productid:product.id,renterid:params[:id])

    end

    def reject 
        applicant=Applicant.find_by(renter_id:params[:id])
        product=Product.find(applicant.product_id)
        unless product.user_id==current_account.accountable_id
            redirect_to owner_path
            return
        end
        applicant.status="Rejected" 
        applicant.save
        redirect_to view_path(product)
    end

    def destroy
        applicant=Applicant.find(params[:id])
        product=Product.find(applicant.product_id)
        unless applicant.renter_id==current_account.accountable_id
            render json: { message: "You are not authorized to view this page"} , status: :forbidden
            return
        end
        app=applicant.destroy
        render json: app , status: :ok


    end

  
end