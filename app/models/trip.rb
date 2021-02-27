class Trip < ApplicationRecord
  belongs_to :lead_user, class_name: "User", foreign_key: "user_id"
  belongs_to :city

  validates :name, presence: true
end
