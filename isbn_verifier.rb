def calculate_check_digit isbn
  multiplied = isbn.map.with_index do |number, index|
    if index.odd?
      number.to_i * 3
    else
      number.to_i
    end
  end

  sum_all = multiplied.reduce do |sum, number|
    sum + number
  end

  valid_check_digit = 10 - sum_all % 10
  if valid_check_digit == 10
    valid_check_digit = 0
  else
    valid_check_digit
  end
end

def valid_isbn? isbn
  return false unless isbn.length == 13
  given_check_digit = isbn.pop.to_i
  correct_check_digit = calculate_check_digit isbn
  given_check_digit == correct_check_digit ? true : false
end

def get_numbers isbn
  isbn.gsub(/[-\s]/, "").split('')
end

puts "Isbn 13 verifier and generator".upcase.center(80)
puts "------------".center(80)
answer = 'y'

until answer == 'n'
  puts "Would you like to verify an isbn (1) or generate a valid check digit for your isbn (2) ?".center(80)
  
  mode = gets.chomp.to_i

  if mode == 1
    puts "Enter an ISBN-13"
    isbn = gets.chomp
    isbn_numbers = get_numbers isbn

    if valid_isbn? isbn_numbers
      puts "This ISBN-13's check digit is valid"
    else
      puts "Invalid ISBN-13 #{isbn}"
    end
  else
    puts "Enter the ISBN for which you'd like to generate a check digit"

    isbn = gets.chomp
    check_digit = calculate_check_digit isbn_numbers

    puts "The check digit for the your ISBN is #{check_digit}."
    puts "Your ISBN-13 is: #{isbn}-#{check_digit}"
  end
  puts "Would you like to use me again? Yes (Y) or No (N)?"
  answer = gets.chomp.downcase
end

puts "Hope my services came in handy to you!"