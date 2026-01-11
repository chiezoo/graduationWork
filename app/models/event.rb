class Event < ApplicationRecord
  belongs_to :user
  
  attribute :time, :datetime

  def self.ransackable_attributes(auth_object = nil)
    [
      "id", "title", "time", "medicine1", "medicine2", "medicine3", 
      "pain_level", "memo", "created_at", "updated_at", "user_id"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end