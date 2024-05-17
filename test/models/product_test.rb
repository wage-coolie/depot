require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def new_product(image_url)
  	product = Product.new(title: 'A new Product', description: 'description', image_url: image_url, price: 1)
  end

  test 'product attributes should not be empty' do
		product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:image_url].any?
		assert product.errors[:price].any?
  end

  test 'product price must be positive' do
  	product = Product.new(title: 'A product', description: 'the produict\'s description', image_url: 'test.png')
  	product.price = -1
  	assert product.invalid?
  	assert_equal ['must be greater than or equal to 0.01'], product.errors['price']
  	product.price = 0
  	assert product.invalid?
  	assert_equal ['must be greater than or equal to 0.01'], product.errors['price']
  	product.price = 1
  	assert product.valid?
  end

  test 'valid_image_url' do
  	ok = %w{ fred.gif fred.jpg fred.png}
  	bad = %w{ fred.doc fred.gif/more fred.gif.more }
  	ok.each { |image_url| assert new_product(image_url).valid?, 'Must be valid' }
  	bad.each { |image_url| assert new_product(image_url).invalid?, 'Must be invalid' }
  end

  test 'product is not valid without a uniq title' do
  	product = Product.new(products(:ruby).attributes)
  	assert product.invalid?
  	assert_equal ['has already been taken'], product.errors[:title]
	end
end
