class Widget < ApplicationRecord
  # Setup option names
  OPTIONS = [:apples, :bananas, :blueberries, :coconuts, :grapes, :lemons, :peaches, :raspberries, :strawberries, :watermelons, :cherries].freeze

  include MultiEnum
end
