class MyWorker
    include Sidekiq::Worker

    def perform(applicant_id)
        ActiveRecord::Base.transaction do
            begin
                # mutex = Mutex.new
                # mutex.lock
                # applicant=Applicant.find_by(id:applicant_id)
                # applicants=Applicant.where(product_id:applicant.product_id)
                # applicants.each do |app|
                #     app.status="Rejected"
                #     app.save
                # end
                # applicant.status="Accepted" 
                # applicant.save
                # product=Product.find_by(id:applicant.product_id)
                # product.status="Unavailable"
                # product.save
                # mutex.unlock
           
            applicant=Applicant.find_by(id:applicant_id)
            applicant.with_lock do
                applicants=Applicant.where(product_id:applicant.product_id)
                applicants.each do |app|
                    app.status="Rejected"
                    app.save
                end
                applicant.status="Accepted" 
                applicant.save
                product=Product.find_by(id:applicant.product_id)
                product.status="Unavailable"
                product.save
            end
            rescue => e
                # Handle any exceptions that occur during the transaction
                puts "...........####################............"
                puts "Error: #{e.message}"
                raise ActiveRecord::Rollback
            end
        end
    end

end
