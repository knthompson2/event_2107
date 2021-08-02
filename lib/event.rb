class Event
  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    item_food_trucks = []
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |food_item, amount|
        if item == food_item
          item_food_trucks << food_truck
        end
      end
    end
    item_food_trucks
  end


  def total_inventory
    ti_hash = {}
      @food_trucks.each do |food_truck|
        food_truck.inventory.each do |item, amount|
          if ti_hash[item].nil?
            ti_hash[item] = {quantity: amount, food_trucks:[food_truck]}
          else
            ti_hash[item][:quantity] += amount
            ti_hash[item][:food_trucks] << food_truck
          end
        end
      end
      ti_hash
  end

  def overstocked_items
    all_items = []
    total_inventory.each do |item, hash|
      if total_inventory[item][:quantity] > 50 && total_inventory[item][:food_trucks].length > 1
        all_items << item
      end
    end
    all_items.flatten

  end

end
