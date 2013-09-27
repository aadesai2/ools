class User < ActiveRecord::Base
  attr_accessible :username      , :temp_u


         has_many :posts
  has_many :replies

 validates_presence_of :temp_u
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :is_admin

  end


