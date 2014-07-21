class Article < ActiveRecord::Base
  acts_as_commentable
  include PublicActivity::Model
  belongs_to  :user
end
