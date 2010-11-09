require "rspec"
require "../prime_finder"

describe "PrimeFinder" do

  before(:each) do
    @primefinder = PrimeFinder.new
  end

  it "can determine if a number is prime or not" do
    @primefinder.number_is_prime?(2).should be(true)
    @primefinder.number_is_prime?(3).should be(true)
    @primefinder.number_is_prime?(4).should_not be(true)
    @primefinder.number_is_prime?(5).should be(true)
    @primefinder.number_is_prime?(100).should_not be(true)
    @primefinder.number_is_prime?(101).should be(true)
    @primefinder.number_is_prime?(773).should be(true)
    @primefinder.number_is_prime?(97777).should be(true)
    @primefinder.number_is_prime?(97779).should be(false)
  end

  it "can determine if a floating point number represents an integer to a given degree of precision" do
    @primefinder.num_is_integer_within_tolerance(2.5).should_not be(true)
    @primefinder.num_is_integer_within_tolerance(2.999999).should_not be(true)
    @primefinder.num_is_integer_within_tolerance(2.99999999999999999999999).should be(true)
    @primefinder.num_is_integer_within_tolerance(2.0000000001).should be(false)
    @primefinder.num_is_integer_within_tolerance(2.00000000001).should be(true)
  end

end