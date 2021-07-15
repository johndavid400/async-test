class Widget < ApplicationRecord

  # Setup option names
  def self.option_list
    %i(apples bananas blueberries coconuts grapes lemons peaches raspberries strawberries watermelons)
  end

  # Convert array of names into a hash with sequentially doubling values
  def self.options_hash(n = 1, o = option_list)
    (n..(o.count - 1)).map{ |x| [o[x], n *= 2] }.prepend([o[0], 1]).to_h
  end

  # return all option_hash integer values from largest to smallest
  def self.options_hash_values
    options_hash.values.sort.reverse
  end

  # subtract options_hash_values starting with largest, until left with 0
  # this should return list of all options as integer array
  def option_ids
    x = option_id
    self.class.options_hash_values.select{ |n| (x - n).negative? ? next : x -= n }
  end

  # converts option_ids integers to array of matching names from option_list
  def options
    hash = self.class.options_hash.invert
    option_ids.sort.map{|id| hash[id] }
  end

  ######## Finder methods ########

  # Find all possible option_ids for a given option_list item
  def self.ids_for_option(option = nil)
    id = options_hash.with_indifferent_access[option]
    possibilities = (0..max_option_id).map{|s| [s, self.new(option_id: s).option_ids ] }.to_h
    ids = possibilities.select{|k,v| v.include?(id) }.keys
  end

  # find by single option
  def self.find_by_option(option = nil)
    where(option_id: ids_for_option(option))
  end

  # find by array of options
  def self.find_by_options(options = [])
    ids = options.map{|option| ids_for_option(option) }.flatten
    where(option_id: ids)
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
