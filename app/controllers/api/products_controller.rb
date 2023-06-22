class Api::ProductsController < Api::ApiController
    before_action :is_owner?

    def index
        user=User.find(current_account.accountable_id)
        products=user.products
        if products
            render json: products , status: :ok
        else
            render json: {message:"No products found"}, status: :not_found
        end
        

    end

    def show
        product=Product.find_by(id:params[:id])
        if product
            render json: product , status: :ok
        else
            render json: {message:"product not found"}, status: :not_found
        end
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
        product.user_id=current_account.accountable_id
        product.image.attach(image)
        if product.save
            render json: product ,status: :ok
        else
            render json: { message: "Error while saving"}, status: :unprocessable_entity
        end
    end

    def edit
        product = Product.find_by(id:params[:id])
    end

    def update
        product = Product.find_by(id:params[:id])
        unless product.user_id==current_account.accountable_id
            render json: { message: "You are not authorized for this action"} , status: :forbidden
            return
        end
        if product.update(product_params)
            render json: { message: "Updated successfully"}, status: :ok
        else
            render json: { message: "Error while updating"}, status: :not_found
        end
    end

    def destroy
        product = Product.find_by(id:params[:id])
        unless product.user_id==current_account.accountable_id
            render json: { message: "You are not authorized for this action"} , status: :forbidden
            return
        end
        if product.destroy
            render json: { message: "Deleted successfully"}, status: :ok
        else
            render json: { message: "Error while deleting"}, status: :not_found
        end

    end

    def product_params
        params.require(:product).permit(:name,:rent,:status,:image,:description)
    end

    private
    def is_owner?
        unless current_account && current_account.user?
            render json: {message: "You are not authorized to view this page"} , status: :unauthorized
        end
    end
end
