class Customer < ApplicationRecord
  has_many :cart_items
  has_many :addresses

  has_many :orders

  def full_name
    this.last_name + this.first_name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
