class Checkout
	attr_reader :basket
	def initialize(rules)
   		@rules = rules 
   		@basket = [] 
  	end

  	def scan(item)
  		case item
  		when "GR1"
  		  hash_GR1 = {:id => "GR1", :price => 3.11 }
  		  @basket.push(hash_GR1)
  		when "SR1"
  		  hash_SR1 = {:id => "SR1", :price => 5.00 }
  		  @basket.push(hash_SR1)
  		when "CF1"
  		  hash_CF1 = {:id => "CF1", :price => 11.23 }
  		  @basket.push(hash_CF1)
  		else
  			puts "We don't have " + item + " in stock"
  		end
  	end

  	# Method for calculate discount of tea
  	# totalGR1Count is total number of tea in basket
	# totalPrice variable is total price of basket without discount
	# priceOfProduct is unit price of product
	def calculate2x1Discount(totalGR1Count, totalPrice, priceOfProduct)
		# In case of total number of tea is odd, substract 1 for calculate offer 2x1
		if totalGR1Count % 2 != 0
			totalPriceGR1 = (totalGR1Count - 1) * priceOfProduct
			totalPriceGR1Reducted = totalPriceGR1 / 2
			differenceOfPrice = totalPriceGR1 - totalPriceGR1Reducted
			totalPrice -= differenceOfPrice
			totalPrice.round(2)
		# Otherwise total price of tea divide between 2
		else
			totalPriceGR1 = totalGR1Count * priceOfProduct
			totalPriceGR1Reducted = totalPriceGR1 / 2
			differenceOfPrice = totalPriceGR1 - totalPriceGR1Reducted
			totalPrice -= differenceOfPrice
			totalPrice.round(2)
		end
	end

	# Method for calculate discount of strawberries
	# totalSR1Count is total number of strawberries in basket
	# totalPrice variable is total price of basket without discount
	# priceOfProduct is unit price of product
	def calculateStrawberryDiscount(totalSR1Count, totalPrice)
		if totalSR1Count >= 3
			totalPrice -= (totalSR1Count * 0.50) 
			totalPrice.round(2)
		end
		totalPrice.round(2)
		
	end

	# Method for calculate discount of coffee
	# totalCF1Count is total number of coffee in basket
	# totalPrice variable is total price of basket without discount
	# priceOfProduct is unit price of product
	def calculateCoffeeDiscount(totalCF1Count, totalPrice, priceOfProduct)
		if totalCF1Count >= 3
			totalPriceCF1 = totalCF1Count * priceOfProduct
			discount = totalPriceCF1 * 2 / 3
			differenceOfPrice = totalPriceCF1 - discount
			totalPrice -= differenceOfPrice
			totalPrice.round(2)
		end
		totalPrice.round(2)
	end

	# Method for getting price of given code of product
	def getPriceOfProduct
		@basket.each_with_object({}) do |item, products|
  			products[item[:id]] = item[:price]
		end
	end

	def total
		@priceOfProduct = getPriceOfProduct
		@totalPrice = @basket.map {|item| item[:price] }.reduce(:+)
		case @rules
		when "CEO_rules" 
			# Total number of tea in the basket
			@totalGR1Count = @basket.count { |h| h[:id] == 'GR1' }
			calculate2x1Discount(@totalGR1Count, @totalPrice, @priceOfProduct['GR1'])
		when "COO_rules"
			# Total number of strawberries in the basket
			@totalSR1Count = @basket.count { |h| h[:id] == 'SR1' }
			calculateStrawberryDiscount(@totalSR1Count, @totalPrice)
		when "CTO_rules"
			# Total number of coffee in the basket
			@totalCF1Count = @basket.count { |h| h[:id] == 'CF1' }
			calculateCoffeeDiscount(@totalCF1Count, @totalPrice, @priceOfProduct['CF1'])
		end
	end
end

co = Checkout.new("CTO_rules")
co.scan("GR1")
co.scan("SR1")
co.scan("CF1")
co.scan("CF1")
co.scan("CF1")
price = co.total
puts price