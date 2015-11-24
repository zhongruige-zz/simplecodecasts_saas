class Users::RegistrationsController < Devise::RegistrationsController
    
    def create
        super do |resource|
            if params[:plan]
                resource.plan_id = params[:plan] # Sets plan_id in the db when a form is submitted
                if resource.plan_id == 2
                    resource.save_with_payment
                else
                    resource.save
                end
            end
        end
    end
end