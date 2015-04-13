class Chapter < ActiveRecord::Base
  belongs_to :comic
  has_many :pages, dependent: :destroy
  
  mount_uploader :cover, CoverUploader
  
  include RankedModel
  ranks :row_order
end
