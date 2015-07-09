class Game < ActiveRecord::Base
    belongs_to :user

    after_initialize :defaults

    def defaults
        self.score ||= 0
        self.progress ||= 0
        self.completed ||= false
    end
end
