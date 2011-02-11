#!/usr/bin/env ruby1.9.1

class Node
	attr_accessor :word, :neighbors, :target_word
	
	def initialize(word, target_word, word_list)
		@word = word
		@target_word = target_word
	  self.neighbors=(word_list)
	end
	
	def neighbors=(word_list)
		@neighbors = generate_node_neighbors(word_list)
	end	

  def hashset_sort(hash)
    hash.sort { |k,v| k[1]<=>v[1] }
  end

	private 
	def generate_node_neighbors(word_list)
	  neighbors = {} # hash of form {word => # letters different from target_word}
		  word_list.each do |word|
			  if numb_letters_different(@word, word) == 1
				  neighbors[word] = numb_letters_different(word, target_word)
			  end		
		  end
		neighbors
	end
	
	def numb_letters_different(word1, word2)
    letters_diff = 0
    zipped = word1.chars.to_a.zip word2.chars.to_a
		zipped.each do |letter_set|
			if letter_set[0] != letter_set[1]
	  	  letters_diff += 1
    	end
    end
    letters_diff
  end
end

class WordLadders
  attr_accessor :start_word, :end_word, :word_list

  def initialize(start_word, end_word)
    @start_word = start_word
    @end_word = end_word
  end

  def build_all
    start_node = Node.new(@start_word,@end_word,@word_list)
    start_node.hashset_sort(start_node.neighbors)
    all_word_ladders = []
    start_node.neighbors.each_key do |neighboring_word|
      adjacent_node = Node.new(neighboring_word, @end_word, @word_list)
      word_ladder = [start_node.word]
      word_ladder << find_ladder_to_end_word(adjacent_node)
      if !word_ladder.include? nil
        all_word_ladders << word_ladder
      end
    end
    all_word_ladders
  end

  def find_ladder_to_end_word(starting_node)
    max_depth = 18
    current_depth = 0
    word_ladder = []
    visited_words = []
    current_node = starting_node
    while current_node.word != @end_word
      current_depth += 1
      if current_depth > max_depth
        word_ladder = nil
        break
      end
      if visited_words.include? current_node.word
        next
      end
      word_ladder << current_node.word
      visited_words << current_node.word
      next_node = Node.new(nearest_neighbor(current_node.neighbors),@end_word,@word_list)
      current_node = next_node
    end
    if word_ladder != nil
      word_ladder << @end_word
    end
    word_ladder
  end

  def print(all_word_ladders)
	  all_word_ladders.each do |path|
		  puts "__--Word Ladder--__"
		  puts path
	  end
  end

  private
  def nearest_neighbor(neighbors)
    letters_different = neighbors.values
    letters_different.sort!
    neighbors.key letters_different[0]
  end
end

class WordLaddersClient
  public
  def run(word_list_filename)
    user_input = get_user_input
    start_word = user_input[0]
    end_word = user_input[1]
    word_ladders = WordLadders.new(start_word, end_word)
    word_ladders.word_list = read_word_list(word_list_filename)
    all_word_ladders = word_ladders.build_all
    if all_word_ladders.size == 0
      puts "No Word Ladders for #{start_word} to #{end_word}"
    else
      word_ladders.print(all_word_ladders)
    end
  end
  
  private
  def get_user_input 
	  puts 'Enter start word and end word'
	  user_input = gets
	  user_input.downcase.scan(/[\w']+/)
  end

  def read_word_list(filename)
    raw_words = File.read(filename)
    raw_words.downcase.scan(/[\w']+/)
  end
end

client = WordLaddersClient.new
client.run("5_letter_words.txt")