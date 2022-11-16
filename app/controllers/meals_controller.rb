require_relative "../views/meals_view"
require_relative "../models/meal"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def add
    name = @meals_view.ask_user_for("name")
    price = @meals_view.ask_user_for("price").to_i
    meal = Meal.new(name: name, price: price)
    @meal_repository.create(meal)
    @meals_view.display(@meal_repository.all)
  end

  def list
    @meals_view.display(@meal_repository.all)
  end
end
