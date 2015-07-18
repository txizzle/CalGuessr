class Game < ActiveRecord::Base
    belongs_to :user

    has_and_belongs_to_many :questions

    after_initialize :defaults

    def defaults
        self.score ||= 0
        self.progress ||= 1
        self.completed ||= false
    end
end
