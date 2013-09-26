class Reply < ActiveRecord::Base
  attr_accessible :description, :id, :num_likes, :post_id, :temp_r
  validates_presence_of :description
  belongs_to :user
end
