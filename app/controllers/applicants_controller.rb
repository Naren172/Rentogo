class ApplicantsController < ApplicationController
     def new
        @applicant=Applicant.new
        @applicant.status="Applied"
        @renter=Renter.first
        @applicant.renter_id=@renter.id
        @product=Product.find(params[:id])
        @product.applicants<<@applicant
        @applicant.save
        @product.save
        redirect_to renter_path 
    end


    def show
        @product=Product.find(params[:id])
    end


    def index
        @applicants=Applicant.all
    end


    def view       
        @products=Product.find(params[:id])
        @applicants=@products.applicants
        @renter=[]
        @applicants.each do |applicant|
            if(applicant.status!="Rejected")
                @renter<<Renter.find(applicant.renter_id)
            end
        # @applicants=Applicant.where(product_id:product.id)
        end
    end


    def accept
        @applicant=Applicant.find_by(renter_id:params[:id])
        @applicants=Applicant.where(product_id:@applicant.product_id)
        @applicants.each do |app|
            app.status="Rejected"
            app.save
        end
        @applicant.status="Accepted" 
        @applicant.save
        @product=Product.find(@applicant.product_id)
        @product.status="Unavailable"
        redirect_to add_path(@product)

    end


    def reject 
        puts("hii")
        @applicant=Applicant.find_by(renter_id:params[:id])
        @applicant.status="Rejected" 
        @applicant.save
        @product=Product.find(@applicant.product_id)
        redirect_to view_path(@product)
    end

    
    def destroy
        @applicant=Applicant.find(params[:id])
        @applicant.destroy

        redirect_to applications_path

    end
end