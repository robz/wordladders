#!/usr/local/bin/ruby -w

  def words_from_string(string)
    string.downcase.scan(/[\w']+/)
  end

  def one_letter_off(string1,string2)
    letters_diff = 0
    result = false
    zipped = string1.chars.to_a.zip string2.chars.to_a
    zipped.each do |letter_set|
      if letter_set[0] == letter_set[1]
	    letters_diff += 1
      end
    end
    if letters_diff == 1
      result = true
    end
    result 
  end

puts 'Enter start word and end word'
user_input = gets
user_input = words_from_string(user_input)

start_word = user_input[0]
end_word = user_input[1]

raw_words = File.read("test_words.txt")
word_list = words_from_string(raw_words)
adj_words_to_start_word = []

word_list.each do |word|
  if one_letter_off(start_word, word)
    adj_words_to_start_word.insert(-1, word) 
  end
end

puts adj_words_to_start_word

