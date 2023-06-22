class Api::MainController <  Api::ApiController
    
    before_action :is_renter?, except: [:getallrenters,:getallusers,:landing]
    def index
        products=Product.all
        render json: products , status: :ok
    end

    def show
        product=Product.find_by(id:params[:id])
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
            render json: {message: "You are not authorized to view this page"} , status: :unauthorized
        end
    end


end
