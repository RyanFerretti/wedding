class Comment < ActiveRecord::Base
  belongs_to :post

  validates_presence_of :author
  validates_presence_of :body
end
