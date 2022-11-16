require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv
  end

  def find_by_name(name)
    @employees.find { |employee| employee.name == name }
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
