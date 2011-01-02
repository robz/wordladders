#! /usr/local/bin/ruby -w
require 'set'

class WordGraph
  
  attr_accessor :nodes

  def readDictionary(filename) 
    file = File.open(filename, "r")
    dictionary = file.read
    dictionary.split(" ")
  end

  def findAdjacentWords(currentWord, possibleAdjacentWords)
    adjacentWords = Set.new
    possibleAdjacentWords.each do |word|  
      if isOneLetterDifferent(currentWord, word)
	    adjacentWords.add(word)
      end
    end
    adjacentWords
  end

  def isOneLetterDifferent(headWord, compareWord)
    headWord = headWord.split(//)
    compareWord = compareWord.split(//)
    for i in 0...headWord.length
	  if (headWord[i] == compareWord[i])
        return true
	  else
	    return false  
 	  end  
    end
  end

end

class Node

  attr_accessor :word, :adjacentWords

  def initialize(word,adjacentWords)
    @word = word
    @adjacentWords = adjacentWords
  end   
  
  def to_s
    @word + "::" + @adjacentWords
  end

  def isOneLetterDifferent(word1, word2)
	eql = 0
    for i in 1..word1.length
	  if word1[i].eql?(word2[i]) 
	    eql += 1
	  end
	end
	return eql
  end
	     
end

n = Node.new("hello",['hello','jello','mello','cello'])
n.adjacentWords.each { |word1| 
  if n.isOneLetterDifferent(n.word, word1) == (word1.length - 1)
	puts word1
  end
}

h = n.isOneLetterDifferent("hello",n.adjacentWords[1])

puts h

