class Chapter < ActiveRecord::Base
  belongs_to :comic
  has_many :pages, dependent: :destroy
end
