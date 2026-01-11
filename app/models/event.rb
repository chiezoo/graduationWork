class Event < ApplicationRecord
  belongs_to :user
  
  attribute :time, :datetime

  
end
