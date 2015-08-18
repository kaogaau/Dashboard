class User < ActiveRecord::Base
  attr_accessible :account, :password, :power
end
