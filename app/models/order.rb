# frozen_string_literal: true

class Order
  #  id, a meal, a customer, an employee plus a delivered
  attr_accessor :id
  attr_reader :meal, :customer, :employee

  def initialize(attributes = {})
    @id        = attributes[:id]
    @meal      = attributes[:meal]      # instance of meal
    @customer  = attributes[:customer]  # instance of customer
    @employee  = attributes[:employee]  # instance of employee
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered #=> true || false
  end

  def deliver!
    @delivered = true
  end

end
