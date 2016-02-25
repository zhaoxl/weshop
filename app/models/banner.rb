class Banner < ActiveRecord::Base
  acts_as_list
  
  mount_uploader :image, BannerImageUploader
end
