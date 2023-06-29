class ProductsController < ApplicationController
    before_action :authenticate_account!
    before_action :is_owner?

    def index
      user=User.find_by(id:current_account.accountable_id)
      @products=user.products
    end

    def show
      @product=Product.find_by(id:params[:id])
      if @product
        @product
      else
        redirect_to ownerindex_path, error:"Not Found"
      end
    end

    def new
      @product = Product.new
    end

    def create
      account=current_account
      user=User.find_by(id:account.accountable_id)
      userdata=product_params
      image=userdata["image"]
      userdata.delete("image")
      @product=Product.create(userdata)
      user.products<<@product
      # @product=user.products.create(userdata)
      @product.image.attach(image)
      if @product.save
        redirect_to owner_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @product = Product.find_by(id:params[:id])
      if @product
        @product
      else
        redirect_to products_path, error:"Not Found"

      end
    end

    def update
      product = Product.find_by(id:params[:id])
      if product
        unless product.user_id==current_account.accountable_id
          redirect_to owner_path
          return
        end
        if product.update(product_params)
          redirect_to product_path
        else
          render :edit, status: :unprocessable_entity
        end
      else
        redirect_to ownerindex_path, error:"Not Found"
      end
    end
     

    def destroy
      @product = Product.find_by(id:params[:id])
      if @product
        unless @product.user_id==current_account.accountable_id
          redirect_to owner_path
          return
        end
        @product.destroy
        redirect_to owner_path
      else
        redirect_to ownerindex_path, error:"Not Found"
      end
    end


    def product_params
      params.require(:product).permit(:name,:rent,:status,:image,:description)
    end
   
    private
    def is_owner?
        unless account_signed_in? && current_account.user?
          if account_signed_in?
              redirect_to renterindex_path
          else
              redirect_to new_account_session_path
          end
        end
    end
end
