#!/usr/bin/env ruby1.9.1

class Node
	attr_accessor :word, :neighbors, :target_word
	
	def initialize(word, target_word)
		@word = word
		@target_word = target_word
	end
	
	def set_neighbors(word_list)
		neighbors = {} # hash of form {word=># letters different from target_word}
		word_list.each do |word|
			if count_different_letters(@word, word) == 1
				neighbors[word] = count_different_letters(word, target_word)								
			end		
		end
		@neighbors = neighbors
	end
	
	def count_different_letters(word1, word2)
    letters_diff = 0
    zipped = word1.chars.to_a.zip word2.chars.to_a
		zipped.each do |letter_set|
			if letter_set[0] != letter_set[1]
	  	  letters_diff += 1
    	end
    end
    letters_diff
  end

	def equal(node)
		eql = false		
		if @word.eql? node.word and @neighbors.eql? node.neighbors
			eql = true
		end
		eql	
	end
end
  

def words_from_string(string)
	string.downcase.scan(/[\w']+/)
end

def get_user_input 
	puts 'Enter start word and end word'
	user_input = gets
	words_from_string(user_input)
end

def closest_word(neighbors)
	weights = neighbors.values
	weights.sort!
	neighbors.key weights[0]	
end

def print_word_ladder(word_ladder)
	puts "Word Ladder:"
	word_ladder.each do |word|
		puts word
	end
end

user_input = get_user_input
start_word = user_input[0]
end_word = user_input[1]

raw_words = File.read("5_letter_words.txt")
word_list = words_from_string(raw_words)

current_node = Node.new(start_word,end_word)
current_node.set_neighbors(word_list)

max_depth = 10
current_depth = 0 
path = []
visited_words = []

while current_node.word != end_word
	if current_depth >= max_depth
		puts "Max search depth reached -- No word ladder found!"
		break
	end
	if visited_words.include? current_node.word
		next
	end	
		p current_node.word
		p current_node.neighbors
		visited_words << current_node.word
		path << current_node.word
		new_node = Node.new(closest_word(current_node.neighbors),end_word)
  	new_node.set_neighbors(word_list)
		current_node = new_node
		current_depth += 1
end 
path << end_word

print_word_ladder(path)
