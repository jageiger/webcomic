class Comic < ActiveRecord::Base
  has_many :chapters, dependent: :destroy
  has_many :assignments
  has_many :users, through: :assignments
end
