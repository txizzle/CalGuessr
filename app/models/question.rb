class Question < ActiveRecord::Base  
    mount_uploader :image, ImageUploader

    has_and_belongs_to_many :games

    after_initialize :defaults

    def defaults
        self.attempts ||= 0
        self.rating ||= 0
    end

    def self.getrandomqs(x)
    	randomqs = []
    	while randomqs.length < x
    		offset = rand(Question.count)
    		rand_q = Question.offset(offset).first.id
    		if !randomqs.include?(rand_q)
    			randomqs.append(rand_q)
    		end
    	end
    	randomqs
    end
end
