class Dock
  attr_reader :name, 
              :max_rental_time,
              :rental_log

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
  end

  def rent(boat, renter)
    rental_log[boat] = renter
  end

  def charge(boat)
    charge_hash = {}
    charge_hash[:card_number] = rental_log[boat].credit_card_number
    charge_hash[:amount] = rental_cost(boat)
    #rental_cost = boat.price_per_hour * boat.hours_rented
    
    charge_hash
    #Another answer
    #{
    #   :card_number => rental_log[boat].credit_card_number, 
    #   :amount => boat.price_per_hour * boat.hours_rented
    # }
  end

  def rental_cost(boat)
    # require 'pry'; binding.pry
     if boat.hours_rented > max_rental_time
      max_rental_time * boat.price_per_hour
     else
      boat.price_per_hour * boat.hours_rented
     end
  end
end