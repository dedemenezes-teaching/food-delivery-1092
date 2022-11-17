require_relative '../views/customers_view'
require_relative '../views/meals_view'
require_relative '../views/sessions_view'
require_relative '../views/orders_view'
require_relative '../models/order'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    # We need an instance of the MealsView
    @meals_view          = MealsView.new
    @customers_view      = CustomersView.new
    @sessions_view       = SessionsView.new
    @orders_view         = OrdersView.new
    @meal_repository     = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository    = order_repository
  end

  def add
    # 1. ask for the meal
    # 1.0 GET ALL THE MEALS
    all_meals = @meal_repository.all
    # 1.1 Display all the meal
    @meals_view.display(all_meals)
    # 1.2 Ask for which one the user want (INDEX)
    meal_index = @meals_view.ask_user_for('Index').to_i - 1
    # 1.3 Retrive the right meal instance from the all meals array
    user_meal = all_meals[meal_index]

    # 2. Ask for the customer
    # 1.0 GET ALL THE customerS
    all_customers = @customer_repository.all
    # 1.1 Display all the customer
    @customers_view.display(all_customers)
    # 1.2 Ask for which one the user want (INDEX)
    customer_index = @customers_view.ask_user_for('Index').to_i - 1
    # 1.3 Retrive the right customer instance from the all customers array
    user_customer = all_customers[customer_index]



    # 3. Ask for the employee
    # 1.0 GET ALL THE employees => JUST THE RIDERS
    all_riders = @employee_repository.all_riders # return an array of riders employees
    # 1.1 Display all the employees
    @sessions_view.display(all_riders)
    # 1.2 Ask for which one the user want (INDEX)
    employee_index = @sessions_view.ask_user_for('Index').to_i - 1
    # 1.3 Retrive the right employees instance from the all employeess array
    user_rider = all_riders[employee_index]


    # 4. Create the order
    order = Order.new(meal: user_meal, customer: user_customer, employee: user_rider)

    # 5. Store this new order in the repository(ORDER REPO)
    @order_repository.create(order)
  end

  def list_undelivered_orders
    # 1. GET ALL THE ORDERS THAT ARE UNDELIVERED
    orders = @order_repository.undelivered_orders
    # 2. DISPLAY THE UNDELIVERED
    @orders_view.display(orders)
  end

  def list_my_orders(employee_logged_in)
    # 1. GET ALL THE UNDELIVERED
    orders = @order_repository.undelivered_orders
    # 2. FILTER BY THE EMPLOYEE LOGGED IN
    my_undelivered_orders = orders.select do |order|
      order.employee.id == employee_logged_in.id
    end
    # 3. Display the employee undelivered orders
    @orders_view.display(my_undelivered_orders)
  end

  def mark_as_delivered(employee_logged_in)
    list_my_orders(employee_logged_in)
    index = @orders_view.ask_user_for('index').to_i - 1
    user_undelivered_orders = @order_repository.my_undelivered_orders(employee_logged_in)
    order = user_undelivered_orders[index]
    @order_repository.mark_as_delivered!(order)
  end
end
