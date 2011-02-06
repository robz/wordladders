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

  def build
    all_word_ladders = []
    start_node = Node.new(@start_word,@end_word,@word_list)

    start_node.hashset_sort(start_node.neighbors)

    start_node.neighbors.each_key do |neighbor|
      node = Node.new(neighbor, @end_word, @word_list)
      path = search_for_word_ladder(node)
      if path != nil
        path
        all_word_ladders << path
      end
    end
    all_word_ladders
  end

  def search_for_word_ladder(node)
    max_depth = 18
    current_depth = 0
    path = []
    visited_words = []
    end_word = node.target_word
    current_node = node
    while current_node.word != end_word
      current_depth += 1
      if current_depth > max_depth
        path = nil
        break
      end
      if visited_words.include? current_node.word
        next
      end
      path << current_node.word
      visited_words << current_node.word
      new_node = Node.new(nearest_neighbor(current_node.neighbors),end_word,@word_list)
      current_node = new_node
    end
    if path != nil
      path << end_word
    end
    path
  end

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
    all_word_ladders = word_ladders.build
    output_word_ladders(all_word_ladders, start_word, end_word)
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

  def output_word_ladders(all_word_ladders, start_word, end_word)
    if all_word_ladders.size == 0
	    puts "No Word Ladders for #{start_word} to #{end_word}"
    else
	    print(all_word_ladders, start_word)
    end
  end

  def print(all_paths, start_word)
	  all_paths.each do |path|
		  puts "__--Word Ladder--__"
		  puts start_word
		  puts path
	  end
  end
end

client = WordLaddersClient.new
client.run("5_letter_words.txt")