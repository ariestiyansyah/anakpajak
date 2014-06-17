class Article < ActiveRecord::Base
  include PublicActivity::Model
  belongs_to  :user
end
