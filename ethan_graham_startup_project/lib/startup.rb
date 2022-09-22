require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        if @salaries.has_key?(title)
            return true
        else
            return false
        end
    end

    def >(startup)
        self.funding > startup.funding
    end

    def hire(employee_name, title)
        if valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise "invalid title"
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @funding >= @salaries[employee.title]
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else
            raise "Not enough funding"
        end
    end

    def payday
        @employees.each do |employee|
            pay_employee(employee)
        end
    end

    def average_salary
        sum = 0

        @employees.each {|employee| sum += @salaries[employee.title]}
        sum / (@employees.length * 1.0)
        
    end

    def close
        @funding = 0
        @employees = []
    end

    def acquire(other_startup)
        @funding += other_startup.funding
        other_startup.salaries.each do |k, v|
            if !@salaries.has_key?(k)
                self.salaries[k] = v
            end
        end
        other_startup.employees.each {|employee| self.employees << employee}

        other_startup.close
    end
end
