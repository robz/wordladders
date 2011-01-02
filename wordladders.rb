#!/usr/bin/env ruby1.9.1

class Node
	attr_accessor :word, :neighbors
	
	def initialize(word)
		@word = word
	end
	
	def set_neighbors(word_list)
		neighbors = []		
		word_list.each do |word|
			if one_letter_off(@word,word)
				neighbors << word
			end		
		end
		@neighbors = neighbors
	end

end
  
	def words_from_string(string)
    string.downcase.scan(/[\w']+/)
  end

  def one_letter_off(string1,string2)
    letters_diff = 0
    result = false
    zipped = string1.chars.to_a.zip string2.chars.to_a
		zipped.each do |letter_set|
		if letter_set[0] != letter_set[1]
	    letters_diff += 1
      end
    end
    if letters_diff == 1
      result = true
    end
    result 
  end

def run 
	puts 'Enter start word and end word'
	user_input = gets
	user_input = words_from_string(user_input)
end

#start_word = user_input[0]
#end_word = user_input[1]

start_word = 'hey'
end_word = 'day'
raw_words = File.read("test_words.txt")
word_list = words_from_string(raw_words)

current_node = Node.new(start_word)
p current_node.word
current_node.set_neighbors(word_list)
p current_node.neighbors

current_state = start_word
final_state = end_word
max_depth = 4
current_depth = 0 #max number of steps
start_best = current_state
end_best = final_state

while current_depth < max_depth and current_state != end_word
  new_word = neighbor(current_state)
  if one_letter_off(current_word, new_word)
		current_state = new_word
	end	
	if current_state != final_state
		current_depth += 1
	end	
end 

