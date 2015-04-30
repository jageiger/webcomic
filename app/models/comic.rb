class Comic < ActiveRecord::Base
  has_many :chapters, dependent: :destroy
  has_many :pages, through: :chapters
  has_many :assignments
  has_many :users, through: :assignments
  
  mount_uploader :cover, CoverUploader
  mount_uploader :logo, LogoUploader
  mount_uploader :banner, BannerUploader
  mount_uploader :background_img, BackgroundUploader
  
  include RankedModel
  ranks :row_order
end
