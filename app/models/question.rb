class Question < ActiveRecord::Base
    mount_uploader :image, ImageUploader

    has_and_belongs_to_many :games

    after_initialize :defaults

    def defaults
        self.attempts ||= 0
        self.rating ||= 1000
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

    def update_rating(delta, dif)
      if delta < 500
        #count guess as Win for User
        gamma = [3.5 - dif/750, 1.0].max
        self.rating += [16*gamma*(-1 + dif/600), -1].min
      elsif 500 <= delta and delta <= 1500
        #count guess as Draw for User
        change = 16*(dif/600)
        self.rating = self.rating + change + (1000-dif)/1000*(change.abs)
      else
        #count guess as Loss for User
        gamma = 3.5 - dif/250
        self.rating += [16*gamma*(1 + dif/600), 1].max
      end
    end
end
