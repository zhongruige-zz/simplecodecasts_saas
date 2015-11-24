class Users::RegistrationsController < Devise::RegistrationsController
    before_filter :select_plan, only: :new# Allows us to run code before anything in the controller is run
    
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
    
    private
        def select_plan
            unless params[:plan] && (params[:plan] == '1' || params[:plan] == '2')
                flash[:notice] = "Please select a membership plan to sign up."
                redirect_to root_url
            end
        end
end