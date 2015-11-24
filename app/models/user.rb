class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan # note this is plural because user has to be part of one or the other
  attr_accessor :stripe_card_token # Allows us to use this which we set on the form
  
  def save_with_payment
    if valid? # That it is a valid user if added validation to form
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token) # Charges a customer and Stripe returns an ID for that customer
      self.stripe_customer_token = customer.id # Need to run a migration and add this stripe_customer_token to the db
      save!
    end
  end
  
end
