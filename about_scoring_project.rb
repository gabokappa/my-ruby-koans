require File.expand_path(File.dirname(__FILE__) + '/neo')

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

def score(dice)
    # You need to write this method ( i looked it up here: https://github.com/javierjulio/ruby-koans-completed/blob/master/about_scoring_project.rb
  points = 0
  #above - we set the total number of points at the start as 0
  counts = Hash.new(0)
  #above - create a hash named "counts" with default value 0

  dice.each do |number|
    counts[number] += 1
    end
    #above - we iterate through the array "dice" and assign the var "number"
    #that number is then added as a key to the "counts" hash nd given a value of
    #+=1. Through iteration if the same key is encountered it increments the value by 1.
    #So if there are two keys of 5 then the value is 2 .g {5 => 2}


  counts.each do |num_rolled, times_rolled|
    #above we iterate over each key value pair and assign num_rolled to the key
    #and times_rolled to the value which is the ammount of times the key occurred
    if num_rolled == 1 && times_rolled >= 3
      points += 1000
      times_rolled -= 3
    end
    # if the key of the hash counts is 1 and has a value of 3 (it has been rolled 3 times)
    #then 1000 is added to the points and 3 is removed from the value leaving it {1 => 0}

    if num_rolled != 1 && times_rolled >= 3
      points += 100 * num_rolled
      times_rolled -= 3
    end

    if num_rolled == 1 && times_rolled <= 2
      points += 100 * times_rolled
    end

    if num_rolled == 5 && times_rolled <= 2
      points += 50 * times_rolled
    end
  end
  points
end

class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, score([2,2,2])
    assert_equal 300, score([3,3,3])
    assert_equal 400, score([4,4,4])
    assert_equal 500, score([5,5,5])
    assert_equal 600, score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, score([2,5,2,2,3])
    assert_equal 550, score([5,5,5,5])
    assert_equal 1100, score([1,1,1,1])
    assert_equal 1200, score([1,1,1,1,1])
    assert_equal 1150, score([1,1,1,5,1])
  end

end
