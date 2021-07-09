class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search,
    against: {
      title: 'A',
      body: 'B'
    },
    using: {
      tsearch: {
        prefix: true
      }
    }
end
