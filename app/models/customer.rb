class Customer < ApplicationRecord

  belongs_to :order,optional: true

  def full_name
    this.last_name + this.first_name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
