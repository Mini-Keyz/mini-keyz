class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  has_many :simulations, dependent: :destroy

  extend FriendlyId
  friendly_id :slug_fullname, use: :slugged

  def slug_fullname
    "#{first_name}-#{last_name}-#{SecureRandom.hex(2)}"
  end
end
