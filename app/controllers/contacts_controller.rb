class ContactsController < ApplicationController
    def new
        @contact = Contact.new # creating an object, allows us to use it in the view
    end
    
    def create
    end
end
