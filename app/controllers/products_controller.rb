class ProductsController < ApplicationController
    before_action :authenticate_account!
    before_action :is_owner?

    def index
      user=User.find(current_account.accountable_id)
      @products=user.products
    end
    def show
      @product=Product.find(params[:id])
    end
    def new
      @product = Product.new
    end

    def create
      account=current_account
      @user=User.find(account.accountable_id)
      @userdata=product_params
      image=@userdata["image"]
      @userdata.delete("image")
      @product=@user.products.create(@userdata)
      @product.image.attach(image)
      redirect_to owner_path
    end
    def edit
      @product = Product.find(params[:id])
    end

    def update
      @product = Product.find(params[:id])
      puts(@product)
      if @product.update(product_params)
        redirect_to product_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to owner_path
    end

    def product_params
      params.require(:product).permit(:name,:rent,:status,:image)
    end

    private
    def is_owner?
        unless account_signed_in? && current_account.user?
          flash[:alert] = "Unauthorized action"
          if account_signed_in?
              redirect_to renterindex_path
          else
              redirect_to new_account_session_path
          end
        end
    end
end
