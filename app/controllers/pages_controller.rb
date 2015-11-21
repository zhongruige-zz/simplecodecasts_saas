class PagesController < ApplicationController
    def home
        @basic_plan = Plan.find(1) #this is talking about the Plan db table
        @pro_plan = Plan.find(2)
    end
    
    def about
    end
end
