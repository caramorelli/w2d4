require "byebug"

# time complexity: n^2
def my_min_bad(list)
  list.each do |out_el|
    return out_el if list.all? {|in_el| in_el >= out_el}
  end
end

# time complexity: n
def my_min_good(list)
  min = list[0]

  list[1..-1].each_index do |idx|
    min = list[idx] if list[idx] < min
  end

  min
end

# O(n^2 * n!)
def bad_largest_contiguous_subsum(list)
  max = list[0]

  # n
  list[0..-1].each_index do |out_idx|

    # n
    list[(out_idx)..-1].each_index do |in_idx|
      sum_arr = list[out_idx..in_idx]

      # n!
      unless sum_arr.empty?
        sum = sum_arr.reduce(:+)
        max = sum if sum > max
      end
    end
  end

  max
end

def good_largest_contiguous_subsum(list)
  max = list[0]
  sum_arr = [max]

  list[1..-1].each_with_index do |el, idx|
    sum = sum_arr.inject(:+)

    # if sum + el < 0
    #   sum_arr = sum_arr[(idx+1)..-1]
    # end

    # sum + el < el
    if sum + el >= max
      max = sum + el
    end

    if sum < el && sum + el < el
      sum_arr.shift
    else
      max = sum
    end

    sum_arr.push(el)
  end

  max
end

#[2, 3, -6, 7, -6, 7]
def largest_contiguous_subsum2(arr)
  largest = arr.first # 2
  current = arr.first # 2

  return arr.max if arr.all? { |num| num < 0 }

  (1...arr.length).each do |i| # 1 # 2 # 3 # 4
    current = 0 if current < 0 # 2 # 5 # 0 # 7 # 1
    current += arr[i] # 2 + 3 => 5 #  5 + -6 => -1 # 0 + 7 => 7 # 7 + -6 => 1 # 1 + 7 => 8
    largest = current if current > largest # 5 # 5 # 7 # 7 # 8
  end

  largest # 8
end

def test
  list = [0, 3, 5, 4, -5, 10, 1, 90]
  puts "my_min_bad"
  p my_min_bad(list)  # =>  -5

  puts "\nmy_min_good"
  p my_min_good(list)  # =>  -5


  puts "\nbad_largest_contiguous_subsum"
  puts "=> 8 from [5, 3, -7]"
  list = [5, 3, -7]
  p bad_largest_contiguous_subsum(list) # => 8

  puts "=> 8 (from [7, -6, 7])"
  list = [2, 3, -6, 7, -6, 7]
  p bad_largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])

  puts "=> -1 (from [-1])"
  list = [-5, -1, -3]
  p bad_largest_contiguous_subsum(list) # => -1 (from [-1])

  puts "\ngood_largest_contiguous_subsum"
  puts "=> 8 from [5, 3, -7]"
  list = [5, 3, -7]
  p good_largest_contiguous_subsum(list) # => 8

  puts "=> 8 (from [7, -6, 7])"
  list = [2, 3, -6, 7, -6, 7]
  p good_largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])

  puts "=> -1 (from [-1])"
  list = [-5, -1, -3]
  p good_largest_contiguous_subsum(list) # => -1 (from [-1])
end

test
