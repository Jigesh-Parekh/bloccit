#modules kep common functions reusable through application
module RandomData
#sentences to array combine sentence with random amount
	def self.random_paragraph
		sentences = []
		rand(4..6).times do
			sentences << random_sentence
		end

		sentences.join(" ")
	end
#sentences have string as array which picks string amount 3-8 joins them
	def self.random_sentence
		strings = []
		rand(3..8).times do
			strings << random_word
		end

		sentence = strings.join(" ")
		sentence.capitalize << "."
	end
#creates random word of 3-8 characters by joining rand chars
	def self.random_word
		letters = ('a'..'z').to_a
		letters.shuffle!
		letters[0, rand(3..8)].join
	end
end