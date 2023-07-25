class Api::MainController <  Api::ApiController
    
    before_action :is_renter?, except: [:getallrenters,:getallusers,:landing]
    def index
        products=Product.all
        product_data = products.map do |product|
        unless product.unavailable?
            {
            
                id: product.id,
                name: product.name,
                rent:product.rent,
                avatar_url: product.image.attached? ? url_for(product.image) : nil
            
            }
        end
    end
    render json:{products:product_data}

end
    def show
        product=Product.find_by(id:params[:id])
        if product
            ratings=product.ratings
            if(ratings.length>0)
                averagerating=0
                n=0
                ratings.each do |rating|
                    averagerating+=rating.rating
                    n+=1
                end
                averagerating/=n
            end
            render json:{product: product,ratings: ratings, averagerating: averagerating}, status: :ok
        else
            render json: { message: "No product Found"}, status: :not_found
        end
    end

    # custom API's
    def getallusers
        users=User.all
        if users
            accounts=[]
            users.each do |user|
                accounts<<user.account
            end
            render json: accounts, status: :ok
        else
            render json:{message:"No Users found"},status: :not_found
        end

    end

    def getallrenters
        users=Renter.all
        if users
            accounts=[]
            users.each do |user|
                accounts<<user.account
            end
            render json: accounts, status: :ok
        else
            render json:{message:"No Users found"},status: :not_found
        end

    end

    def landing
         render json:{message:"Welcome to RENTOGO"}, status: :ok
    end

    private
    def is_renter?
        unless current_account && current_account.renter?
            render json: {message: "You are not authorized to view this page"} 
        end
    end


end




