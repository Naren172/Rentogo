class Api::ApplicantsController < Api::ApiController
    before_action :is_renter? , except: [:accept,:reject,:view]
    before_action :is_owner? , only: [:accept,:reject,:view]

    def new
        applicant=Applicant.new
        applicant.status="Applied"
        renter=Renter.find(current_account.accountable_id)
        applicant.renter_id=renter.id
        product=Product.find_by(id:params[:id])
        if product
            product.applicants<<applicant 
            product.save
            if applicant.save
                render json: applicant ,status: :created
            else
                render json: { message: "Error while saving"}, status: :unprocessable_entity
            end
        else
            render json: { message: "product not found"}, status: :not_found

        end
    end

    def show
        product=Product.find_by(id:params[:id])
        if product
            render json: product ,status: :ok
        else
            render json: { message: "No Product Found"}, status: :not_found
        end
    end

    def index
        renter=Renter.find(current_account.accountable_id)        
        applicants=Applicant.where(renter_id:renter.id)
        if applicants
            render json: applicants ,status: :ok
        else
            render json: { message: "No Applicants Found"} , status: :not_found
        end
    end

    def view       
        product=Product.find_by(id:params[:id])
        if product
            applicants=product.applicants
            renter=[]
            applicants.each do |applicant|
                if(applicant.status!="Rejected")
                    renter<<Renter.find_by(id:applicant.renter_id)
                end
            end
            if renter
                render json: renter ,status: :ok
            else            
                render json: { message: "No Renters Found"} , status: :not_found
            end
        else
            render json: { message: "No Product Found"}, status: :not_found
        end
    end

    def accept
        applicant=Applicant.find_by(renter_id:params[:renterid],product_id:params[:productid])
        if applicant
            product=Product.find_by(id:applicant.product_id)
            unless product.user_id==current_account.accountable_id
                render json: {message:"You are not authorized for this action"}, status: :forbidden
                return
            end
            applicants=Applicant.where(product_id:applicant.product_id)
            applicants.each do |app|
                app.status="Rejected"
                app.save
            end
            applicant.status="Accepted" 
            applicant.save
            product.status="Unavailable"
            render json: applicant ,status: :ok
        else
            render json: { message: "No Applicant Found"}, status: :not_found
        end
    end

    def reject 
        applicant=Applicant.find_by(renter_id:params[:renterid],product_id:params[:productid])
        if applicant
            product=Product.find_by(id:applicant.product_id)
            unless product.user_id==current_account.accountable_id
                render json: {message:"You are not authorized for this action"}, status: :forbidden
                return
            end
            applicant.status="Rejected" 
            applicant.save
            render json: applicant ,status: :ok
        else
            render json: { message: "No Applicant Found"}, status: :not_found
        end
    end

    def destroy
        applicant=Applicant.find_by(id:params[:id])
        if applicant
            product=Product.find(applicant.product_id)
            unless applicant.renter_id==current_account.accountable_id
                render json: { message: "You are not authorized for this action"} , status: :forbidden
                return
            end
            if applicant.destroy
                render json: {message:"Deleted successfully!"} , status: :ok
            else
                render json:{message:"No Applicants Found!"}, status: :not_found
            end
        else
            render json: { message: "No Applicant Found"}, status: :not_found
        end
    end

    private
    def is_renter?
        unless current_account && current_account.renter?            
            render json: {message: "You are not authorized to view this page"} , status: :unauthorized
        end
    end

    def is_owner?
        unless current_account && current_account.user?            
            render json: {message: "You are not authorized to view this page"} , status: :unauthorized
        end
    end
end