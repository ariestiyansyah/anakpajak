class Answer < ActiveRecord::Base
  belongs_to  :question
  belongs_to  :user
  include Bootsy::Container
end
