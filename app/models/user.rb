class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :events, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["id", "email", "admin", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["events"]
  end
end
