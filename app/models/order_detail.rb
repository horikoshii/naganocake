class OrderDetail < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :items

end
