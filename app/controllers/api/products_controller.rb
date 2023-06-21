class Api::ProductsController < Api::ApiController
    # before_action :authenticate_account!
    # before_action :is_owner?

    def index
        # user=User.find(current_account.accountable_id)
        # products=user.products
        products=Product.all
        render json: products , status: :ok

    end

    def show
        product=Product.find(params[:id])
        render json: product , status: :ok

    end

    def new
        product = Product.new
        render json: product ,status: :ok
    end

    def create
        productdata=product_params
        image=productdata["image"]
        productdata.delete("image")
        product=Product.create(productdata)
                product.user_id=12

        product.image.attach(image)
        if product.save
            render json: product ,status: :ok
        else
            render json: { message: "Error while saving"}, status: :unprocessable_entity
        end
    end

    def edit
        product = Product.find(params[:id])
    end

    def update
        product = Product.find(params[:id])
        # unless product.user_id==current_account.accountable_id
        #     redirect_to owner_path
        #     return
        # end
        if product.update(product_params)
            render json: { message: "Updated successfully"}, status: :ok
        else
             render json: { message: "Error while updating"}, status: :not_found
        end
    end

    def destroy
        product = Product.find(params[:id])
        # unless product.user_id==current_account.accountable_id
        #   redirect_to owner_path
        #   return
        # end
        if product.destroy
            render json: { message: "Deleted successfully"}, status: :ok
        else
             render json: { message: "Error while deleting"}, status: :not_found
        end

    end

    def product_params
        params.require(:product).permit(:name,:rent,:status,:image,:description)
    end

    # private
    # def is_owner?
    #     unless account_signed_in? && current_account.user?
    #       flash[:alert] = "Unauthorized action"
    #       if account_signed_in?
    #           redirect_to renterindex_path
    #       else
    #           redirect_to new_account_session_path
    #       end
    #     end
    # end
end
