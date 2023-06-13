class CheckoutController < ApplicationController
    def create
        product=Product.find(params[:id])
        @session = Stripe::Checkout::Session.create({
      
        payment_method_types: ['card'],
        line_items: [{
            name:product.name,
            amount: product.rent,
            currency:"inr",
            quantity: 1
        }],
        
        mode: 'payment',
        success_url: renter_path,
        cancel_url: rentershow_path ,
      })
      respond_to do |format|
        format.js 
      end
    end
end
