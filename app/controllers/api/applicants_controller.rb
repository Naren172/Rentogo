class Api::ApplicantsController < Api::ApiController
    # before_action :authenticate_account!
    # before_action :is_renter? , except: [:accept,:reject,:view]
     def new
        applicant=Applicant.new
        applicant.status="Applied"
        # account=current_account
        # renter=Renter.find(current_account.accountable_id)
        renter=Renter.first
        applicant.renter_id=renter.id
        product=Product.find(params[:id])
        product.applicants<<applicant 
        product.save
        if applicant.save
            render json: applicant ,status: :ok
        else
            render json: { message: "Error while saving"}, status: :unprocessable_entity
        end
    end

    def show
        product=Product.find_by(id:params[:id])
        render json: product ,status: :ok
    end

    def index
        renter=Renter.first
        applicants=Applicant.where(renter_id:renter.id)
        render json: applicants ,status: :ok
    end

    def view       
        product=Product.find_by(id:params[:id])
        applicants=product.applicants
        renter=[]
        applicants.each do |applicant|
            if(applicant.status!="Rejected")
                renter<<Renter.find(applicant.renter_id)
            end
        # @applicants=Applicant.where(product_id:product.id)
        end
        render json: renter ,status: :ok
    end

    def accept
        applicant=Applicant.find_by(renter_id:params[:renterid],product_id:params[:productid])
        product=Product.find(applicant.product_id)
        # unless product.user_id==current_account.accountable_id
        #     redirect_to owner_path
        #     return
        # end
        applicants=Applicant.where(product_id:applicant.product_id)
        applicants.each do |app|
            app.status="Rejected"
            app.save
        end
        applicant.status="Accepted" 
        applicant.save
        # product=Product.find(applicant.product_id)
        product.status="Unavailable"
        render json: applicant ,status: :ok
    end

    def reject 
        applicant=Applicant.find_by(renter_id:params[:renterid],product_id:params[:productid])
        product=Product.find(applicant.product_id)
        # unless product.user_id==current_account.accountable_id
        #     redirect_to owner_path
        #     return
        # end
        applicant.status="Rejected" 
        applicant.save
        render json: applicant ,status: :ok
    end

    def destroy
        applicant=Applicant.find(params[:id])
        # product=Product.find(applicant.product_id)
        # unless applicant.renter_id==current_account.accountable_id
        #     render json: { message: "You are not authorized to view this page"} , status: :forbidden
        #     return
        # end
        app=applicant.destroy
        render json: app , status: :ok


    end

  
end