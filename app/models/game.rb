class Game < ActiveRecord::Base
    belongs_to :user

    has_and_belongs_to_many :questions

    after_initialize :defaults

    def defaults
        self.score ||= 0
        self.progress ||= 0
        self.completed ||= false
        self.created ||= Time.now
    end

    def self.high_scores
        @games = Game.where('completed' => true).order('score asc').limit(10)
    end
end
