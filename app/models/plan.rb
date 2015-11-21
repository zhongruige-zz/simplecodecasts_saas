class Plan < ActiveRecord::Base
    has_many :users # note this is plural because of more than one user
end