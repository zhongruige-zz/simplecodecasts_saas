class ContactsController < ApplicationController
    def new
        @contact = Contact.new # creating an object, allows us to use it in the view
    end
    
    def create
        @contact = Contact.new(contact_parms) # create a new object, but filling out attributes with the contact_params from form
        
        if @contact.save # this commits it to the db if save works, otherwise it will run the else statement if save fails
        
            # Accessing the params hash and able to get those values, which it grabs from the form
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            
            ContactMailer.contact_email(name, email, body).deliver
            
            flash[:success] = "Message sent." # Giving flash message a key (:success), the message is the value. This then gets passed in through application.html.erb
            redirect_to new_contact_path # loads the contact form page again once saved successuflly
        else
            flash[:danger] = "Error occured, message has not been sent."
            redirect_to new_contact_path
        end
    end
    
    private
        def contact_parms
            params.require(:contact).permit(:name, :email, :comments) # done for security reasons, it's whitelisting these params
        end
end