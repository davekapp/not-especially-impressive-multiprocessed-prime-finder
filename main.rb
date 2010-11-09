$LOAD_PATH << "."
require 'prime_finder.rb'

if __FILE__ == $0
  num = ARGV[0].to_i
  max_proc = ARGV[1].to_i
  ARGV.clear # if you don't clear ARGV, then ARGF doesn't work right, and that seems to totally
  # hose up IO.popen created processes

  primefinder = PrimeFinder.new
  primefinder.find_primes(num, max_proc)
end
