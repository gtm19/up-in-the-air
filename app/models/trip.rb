class Trip < ApplicationRecord
  belongs_to :lead_user, class_name: "User", foreign_key: "user_id"
end
