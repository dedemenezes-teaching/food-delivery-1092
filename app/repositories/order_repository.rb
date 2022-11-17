require 'csv'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    load_csv if File.exist? @csv_file_path
  end

  def create(order)
    # If the orders array has 9 elements
    # my next id should be the last order id + 1
    # i the orders array is empty next_id should be 1
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
    order.id = @next_id
    @orders << order
    save_csv
  end

  def undelivered_orders
    # new array containing only orders undelivered
    @orders.reject { |order| order.delivered? }
  end

  def my_undelivered_orders(employee_logged_in)
    undelivered_orders.select do |order|
      order.employee.id == employee_logged_in.id
    end
  end

  def mark_as_delivered!(order)
    order.deliver!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # p row => #<CSV::Row id:"1" meal_id:"1" customer_id:"2" employee_id:"2" delivered:"false">
      # Convert the attributes to the right data type
      order_id = row[:id].to_i
      # We need to find the right instance of meal by the meal_id
      meal = @meal_repository.find(row[:meal_id].to_i)
      customer = @customer_repository.find(row[:customer_id].to_i)
      employee = @employee_repository.find(row[:employee_id].to_i)
      delivered = row[:delivered] == 'true'

      # Create the order
      # push to orders array
      @orders << Order.new(id: order_id, meal: meal, customer: customer, employee: employee, delivered: delivered)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      # PUSH THE HEADERS
      csv << ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end
end
