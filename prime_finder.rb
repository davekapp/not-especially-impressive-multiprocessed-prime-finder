# This is a rather inefficient class made to try and find prime numbers. The reason I'm making it is because I want
# to try out multiprocessing facilities in Ruby moreso than I want to find a fancy new way to find prime numbers.
# This probably won't work on Windows because it uses IO.popen, which, to my understanding, doesn't work there because
# Windows doesn't have a version of fork(2) that it uses under the hood.
class PrimeFinder

  def number_is_prime?(num)
    return false if num == 1 || num == 0
    return true if num == 2 || num == 3
    return false if num % 2 == 0

    sqrt_of_num = Math::sqrt(num).ceil
    2.upto(sqrt_of_num) do |n|
      next if n % 2 == 0 #evens automatically not prime
      #if num_is_integer_within_tolerance(num/n.to_f)
      if num % n == 0
        return false
      end
    end
    true
  end

  def num_is_integer_within_tolerance(num)
    (num.to_i - num).abs < 0.0000000001 ? true : false
  end

  def find_primes(num, max_processes = 1)
    primes = []
    number_of_processes_running = 0
    processes = {}
    current_num = 1
    while current_num < num
      if number_of_processes_running < max_processes
        p = IO.popen("-", "w+")
        if p #parent
          number_of_processes_running += 1
          processes[p.pid] = p
          p.puts current_num
          p.close_write
          current_num += 1
        else #child
          num_to_calc = gets.chomp.to_i
          #STDERR.puts "calculating #{num_to_calc}"
          is_prime = number_is_prime?(num_to_calc)
          #STDERR.puts "#{num_to_calc} is prime: #{is_prime}"
          primes << num_to_calc if is_prime
          #STDERR.puts "size of results: #{primes.size}"
          if is_prime
            puts num_to_calc
            exit 0
          end
          exit 1
        end
      else # wait for a child to finish
        pid, status = Process.wait2
        if status == 0
          p = processes[pid]
          primes << p.gets.chomp.to_i
        end

        processes.delete pid
        number_of_processes_running -= 1
      end
    end
    print_results(primes)
  end

  def print_results(results)
    results.each do |prime_num|
      puts prime_num
    end
  end
end