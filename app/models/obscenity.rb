require 'obscenity/active_model'
# ActiveRecord example
class Post < ActiveRecord::Base

  key :description, String

  validates :description,  obscenity: { sanitize: true, replacement:  "[censored]" }
end

# MongoMapper example
class Book
  include MongoMapper::Document
  key :description, String

  validates :description,  obscenity: { sanitize: true, replacement:  :vowels }
end

# Mongoid example
class Page
  include Mongoid::Document
  key :description, String

  validates :description,  obscenity: { sanitize: true, replacement:  :garbled }
end
