class Order < ApplicationRecord
  attr_accessor :cart

  has_many :items, dependent: :destroy
  belongs_to :user

  after_create :build_items

  scope :recent, ->{order created_at: :desc}

  private
  def build_items
    cart.items.each do |item|
      items.create product_id: item.product_id, number: item.quantity,
        price: item.product.price
    end
  end
end
