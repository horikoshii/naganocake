class Order < ApplicationRecord
  belongs_to :order_detail
  has_many :customers, dependent: :destroy
  enum payment_method: { credit_card: 0, transfer: 1 }
end
