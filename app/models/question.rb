class Question < ActiveRecord::Base  
  mount_uploader :image, ImageUploader
end
