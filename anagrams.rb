require "byebug"

  # n! * 2n
def first_anagram?(str, match)
  return false if str.length != match.length

  # n!
  word_arr = []
  char_arr = str.chars
  combo_arr = char_arr.permutation(str.length).to_a
  # debugger

  # n! * n
  combo_arr.each do |chars|
    word_arr << chars.join
  end

  # n! * n + n
  return word_arr.include?(match)
end

# n^3
def second_anagram?(str, match)
  return false if str.length != match.length

  str_arr = str.chars
  char_arr = match.chars

  # n
  char_arr.each do |char|
    # n^2
    idx = str_arr.find_index(char)
    return false if idx.nil?
    # n^3
    str_arr.delete_at(idx)
  end

  true
end

# 2(n*logn)
def third_anagram?(str, match)
  return false if str.length != match.length

  # 2(n*logn)
  s_str = str.chars.sort
  s_match = match.chars.sort

  s_str == s_match
end

# 2n + 2
def fourth_anagram?(str, match)
  return false if str.length != match.length

  match_hsh = Hash.new(0)
  str_hsh = Hash.new(0)

  # n
  str.chars.each do |el|
    str_hsh[el] += 1
  end

  # 2n
  match.chars.each do |el|
    match_hsh[el] += 1
  end

  # 2n + 1
  match_hsh.each do |k, v|
    # 2n + 2
    return false if v != str_hsh[k]
  end

  true
end

# 2n + 1
def fifth_anagram?(str, match)
  return false if str.length != match.length

  hsh = Hash.new(0)

  # n
  str.chars.each do |el|
    hsh[el] += 1
  end

  # 2n
  match.chars.each do |el|
    hsh[el] += 1
  end

  # 2n + 1
  hsh.values.all? {|v| v % 2 == 0}
end

# puts "first_anagram"
# puts first_anagram?("timschafer", "mrshitface")
# puts first_anagram?("timschafer", "mrshitfice")
puts second_anagram?("timschafer", "mrshitface")
puts second_anagram?("timschafer", "mrshitfice")
puts third_anagram?("timschafer", "mrshitface")
puts third_anagram?("timschafer", "mrshitfice")
puts fourth_anagram?("timschafer", "mrshitface")
puts fourth_anagram?("timschafer", "mrshitfice")
puts fifth_anagram?("timschafer", "mrshitface")
puts fifth_anagram?("timschafer", "mrshitfice")
