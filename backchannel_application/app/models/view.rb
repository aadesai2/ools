class View < ActiveRecord::Base
  attr_accessible :like, :post_id, :reply_id, :user_id
end
