class OrderDetail < ApplicationRecord
  has_many :orders, dependent: :destroy
end
