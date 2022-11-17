# frozen_string_literal: true

class SessionsView
  def ask_user_for(stuff)
    puts "#{stuff}?"
    gets.chomp
  end

  def wrong_credentials
    puts 'Wrong credentials. Try again...'
  end

  def welcome_message(employee)
    puts "Welcome, #{employee.username}"
  end

  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username} : #{employee.role}"
    end
  end
end
