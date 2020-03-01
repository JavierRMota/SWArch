# File name: twitter_test.rb
# Observer Method Pattern
# Date: 29-Feb-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

require 'minitest/autorun'
require 'stringio'
require './twitter'

#This tests uses the output of the command line
class TwitterTest < Minitest::Test

  #Initializes test instance variables
  def setup
    @out = StringIO.new
    @old_stdout = $stdout
    $stdout = @out
  end

  def teardown
    $stdout = @old_stdout
  end

  #Test with an Alice in Wonderland Theme
  def test_twitter_alices_adventures_in_wonderland

    #Initialize users
    a = Twitter.new('Alice')
    k = Twitter.new('King')
    q = Twitter.new('Queen')
    h = Twitter.new('Mad Hatter')
    c = Twitter.new('Cheshire Cat')

    #Make some users follow others
    a.follow(c)
    k.follow(q)
    h.follow(a).follow(q).follow(c)
    q.follow(q)

    #Tweet with some users
    a.tweet "What a strange world we live in."
    k.tweet "Begin at the beginning, and go on till you come "  \
      "to the end: then stop."
    q.tweet "Off with their heads!"
    c.tweet "We're all mad here."

    #Compare expected results with the console output
    assert_equal \
      "Mad Hatter received a tweet from Alice: What a strange " \
        "world we live in.\n"                                   \
      "King received a tweet from Queen: Off with their "       \
        "heads!\n"                                              \
      "Mad Hatter received a tweet from Queen: Off with their " \
        "heads!\n"                                              \
      "Queen received a tweet from Queen: Off with their "      \
        "heads!\n"                                              \
      "Alice received a tweet from Cheshire Cat: We're all "    \
        "mad here.\n"                                           \
      "Mad Hatter received a tweet from Cheshire Cat: "         \
        "We're all mad here.\n",                                \
      @out.string
  end

  #Test with a Star Wars Theme
  def test_twitter_star_wars
    #Initialize users
    y = Twitter.new('Yoda')
    o = Twitter.new('Obi-Wan Kenobi')
    v = Twitter.new('Darth Vader')
    p = Twitter.new('Padmé Amidala')

    #Make some users follow others
    p.follow(v)
    v.follow(p).follow(y).follow(v)

    #Tweet with some users
    y.tweet "Do or do not. There is no try."
    o.tweet "The Force will be with you, always."
    v.tweet "I find your lack of faith disturbing."
    o.tweet "In my experience, there's no such thing as luck."
    y.tweet "Truly wonderful, the mind of a child is."
    p.tweet "I will not condone a course of action that will "  \
      "lead us to war."

    #Compare expected results with the console output
    assert_equal \
      "Darth Vader received a tweet from Yoda: Do or do not. "  \
        "There is no try.\n"                                    \
      "Padmé Amidala received a tweet from Darth Vader: I find "\
        "your lack of faith disturbing.\n"                      \
      "Darth Vader received a tweet from Darth Vader: I find "  \
        "your lack of faith disturbing.\n"                      \
      "Darth Vader received a tweet from Yoda: Truly wonderful,"\
        " the mind of a child is.\n"                            \
      "Darth Vader received a tweet from Padmé Amidala: I will "\
        "not condone a course of action that will lead us to "  \
        "war.\n",                                               \
      @out.string
  end

end
