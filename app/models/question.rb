class Question < ActiveRecord::Base  
    mount_uploader :image, ImageUploader

    after_initialize :defaults

    def defaults
        self.attempts ||= 0
        self.correct ||= 0
    end
end
