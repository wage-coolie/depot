class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true

  # this is not optimal as on each render this would recalculate the price, but for now, we will do it this way
  def total_price
  	product.price * quantity
  end
end
