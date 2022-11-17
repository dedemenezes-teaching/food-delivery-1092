# frozen_string_literal: true

require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # 1. Ask for name
    username = @sessions_view.ask_user_for('username')
    # 2. Ask for password
    password = @sessions_view.ask_user_for('password')
    # 3. check it
    # 3.1. Find an employee by the name provided
    employee = @employee_repository.find_by_username(username)
    p employee
    # 3.2.1. check if the employee is present in the database
    # 3.2. Check if the password matches the one provided by the user
    if !employee.nil? && employee.password == password
      # 4. login
      # 4.1. Show a welcome message
      @sessions_view.welcome_message(employee)
      # We return the instance of employee found to use in the router!
      employee
    else
      # 5. Wrong password
      # 5.1. Display wrong credentials message
      @sessions_view.wrong_credentials
      # 5.2  ask for name and password again
      login # RECURSIVE CALL to re-execute the method!
    end
  end
end
