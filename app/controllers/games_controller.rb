class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :prev_question, :next_question, :make_guess]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @question = @game.questions[@game.progress]
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    if user_signed_in?
      params[:game] = { :user_id => current_user.id }
    else
      params[:game] = { :user_id => nil }
    end
    params[:game][:question_ids] = Question.getrandomqs(5)
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def next_question
    if @game.progress.equal?(@game.questions.length - 1)
      @game.update_attribute(:progress, 0)
    else
      @game.update_attribute(:progress, @game.progress + 1)
    end
    @question = @game.questions[@game.progress]
    respond_to do |format|
      format.js {}
    end
  end

  def prev_question
    if @game.progress.equal?(0)
      @game.update_attribute(:progress, @game.questions.length - 1)
    else
      @game.update_attribute(:progress, @game.progress - 1)
    end
    @question = @game.questions[@game.progress]
    respond_to do |format|
      format.js {}
    end
  end

  def make_guess
    @question = @game.questions[@game.progress]
    @delta = (((params[:lat].to_f - @question.lat)*10000*3280.4/90)**2 + ((params[:long].to_f - @question.long)*10000*3280.4/90)**2)**0.5
    newscore = @game.score + @delta
    @game.update_attribute(:score, newscore)
    if @game.progress.equal?(@game.questions.length - 1)
      @game.update_attribute(:completed, true)
      respond_to do |format|
          format.js { render "finish" and return}
      end
    else
      @game.update_attribute(:progress, @game.progress + 1)
    end
    @question = @game.questions[@game.progress]
    @delta = (@delta*100000).round / 100000.0
    
    respond_to do |format|
      format.js { render "make_guess", :locals => {:delta => @delta}}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:user_id, :score, :progress, :completed, { question_ids:[] })
    end
end
