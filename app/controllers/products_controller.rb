class ProductsController < ApplicationController
    def index
        @products=Product.all
    end
    def show
        @product=Product.find(params[:id])
    end
    def new
    @product = Product.new
  end

  def create
    @user=User.first
    @userdata=product_params
    image=@userdata["image"]
    @userdata.delete("image")
    @product=@user.products.create(@userdata)

    if @product
    else

    end
    @product.image.attach(image)

  # rescue StandardError => e 

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
end
