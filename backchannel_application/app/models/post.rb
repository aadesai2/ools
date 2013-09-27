class Post < ActiveRecord::Base
  attr_accessible :category_id, :description, :id, :num_likes, :temp_p, :title    , :category_name
  belongs_to :user
  belongs_to :category
  validates :title, :description, :presence => true
  validates :title, :length => {:minimum => 2 }
  validates :title, :uniqueness => {:message => "Already Taken"}
end
