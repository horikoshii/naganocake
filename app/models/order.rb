class Order < ApplicationRecord
  belongs_to :order_detail
  has_many :customers, dependent: :destroy
end
