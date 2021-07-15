class Widget < ApplicationRecord

  # Setup option names
  def self.option_list
    %i(apples bananas blueberries grapes lemons peaches raspberries strawberries watermelons)
  end

  # Convert array of names into a hash with sequentially doubling values
  def self.options_hash(n = 1, o = option_list)
    (n..(o.count - 1)).map{ |x| [o[x], n *= 2] }.prepend([o[0], 1]).to_h
  end

  # return all option_hash integer values from largest to smallest
  def options_hash_values
    self.class.options_hash.values.sort.reverse
  end

  # subtract options_hash_values starting with largest, until left with 0
  # this should return list of all options as integer array
  def option_ids
    x = option_id
    enum_values.select{ |n| (x - n) < 0 ? next : x -= n }
  end

  # converts option_ids integers to array of matching names from option_list
  def options
    hash = self.class.options_hash.invert
    option_ids.sort.map{|id| hash[id] }
  end

  ####### Test methods - not required to work #######

  # return the total possible number of combinations based on count from option_list
  def self.max_option_id
    (options_hash.values.max * 2) - 1
  end

  # return all combinations and how to achieve them
  def self.test
    (0..max_option_id).map{|s| [s, self.new(option_id: s).option_ids.join(' + ')].join(' = ') }
  end

end
