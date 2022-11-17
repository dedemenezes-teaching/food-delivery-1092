# frozen_string_literal: true

require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv if File.exist? @csv_file_path
  end

  def find_by_username(name)
    @employees.find { |employee| employee.username == name }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def all_riders
    @employees.select { |employee| employee.rider? }
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # Convert the information to the right data type
      row[:id] = row[:id].to_i
      # Instantiate the Employye
      employee = Employee.new(row)
      # push the new employee to our employees array
      @employees << employee
    end
  end
end
