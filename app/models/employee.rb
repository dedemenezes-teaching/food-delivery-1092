class Employee
  attr_reader :name, :password

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @password = attributes[:password]
    @role = attributes[:role]
  end

  def manager?
    @role == 'manager'
  end
end
