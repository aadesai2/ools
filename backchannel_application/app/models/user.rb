class User < ActiveRecord::Base
  attr_accessible :username, :password

  attr_accessor :password
         has_many :posts
  has_many :replies

  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :is_admin

  end


