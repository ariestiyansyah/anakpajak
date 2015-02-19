class Article < ActiveRecord::Base
  acts_as_commentable
  include PublicActivity::Model
  include Bootsy::Container
  belongs_to  :user
end
