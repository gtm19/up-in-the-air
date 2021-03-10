class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :trips
  has_many :trip_participants
  belongs_to :city, optional: true

  validates :email, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
