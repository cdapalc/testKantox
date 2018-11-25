require "minitest/autorun"
require_relative 'checkout'

class CheckoutTest < Minitest::Test
 	def setup 
 	  	@co = Checkout.new("CTO_rules")
 	  	@co.scan("GR1")
 	  	@co.scan("SR1")
 	  	@co.scan("CF1")
 	  	@co.scan("CF1")
 	  	@co.scan("CF1")
 	end

 	def teardown
 		basketProducts = []
 		@co.basket.each do |item|
 			basketProducts.push(item[:id]) 
 		end
 		puts "Basket: " + basketProducts.join(',')
 		puts "Total price expected: £" + @co.total.to_s
 	end

  	def test_calculate_total_basket
    	assert_equal 30.57, @co.total
  	end
end




