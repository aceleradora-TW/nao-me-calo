require 'obscenity/active_model'
# ActiveRecord example
class Post < ActiveRecord::Base

  key :description, String

  validates :description,  obscenity: { sanitize: true, replacement:  "[censored]" }
end

# MongoMapper example
class Book
  key :description, String

  validates :description,  obscenity: { sanitize: true, replacement:  :vowels }
end

# Mongoid example
class Page
  key :description, String

  validates :description,  obscenity: { sanitize: true, replacement:  :garbled }
end
