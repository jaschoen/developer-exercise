class Array
	def where(**search_hash)
		results = []
		self.each do |movie|
			results << movie if search_hash.all? do |key, value|
				value.class == Regexp ? movie[key] =~ value : movie[key] == value
			end
		end
		results
	end
end






