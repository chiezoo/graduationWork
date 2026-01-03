class Event < ApplicationRecord
  belongs_to :user
  
  attribute :start_time, :string
end
