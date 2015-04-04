class Page < ActiveRecord::Base
  mount_uploader :image, PageUploader
  mount_uploader :thumb, ThumbUploader
  belongs_to :chapter
  
  include RankedModel
  ranks :row_order
end
