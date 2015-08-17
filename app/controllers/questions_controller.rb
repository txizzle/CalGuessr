class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :require_admin!, only: [:index]
  respond_to :html, :js

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    path = question_params[:image].path
    new_params = question_params
    exifr = EXIFR::JPEG.new(path)
    if exifr.gps != nil
      new_params[:lat] = (exifr.gps.latitude*10000000).round / 10000000.0
      new_params[:long] = (exifr.gps.longitude*10000000).round / 10000000.0
      noticestring = exifr.gps.latitude.to_s + exifr.gps.longitude.to_s
      @question = Question.new(new_params)
      respond_to do |format|
        if @question.save
          format.html { redirect_to @question, notice: 'Question was successfully created.' }
          format.json { render :show, status: :created, location: @question }
          format.js
        else
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
          format.js
        end
      end
    else
      redirect_to new_question_url, :flash => { :error => "The image you attached doesn't have GPS EXIF data! Please try another image."}
    end



  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:lat, :long, :difficulty, :attempts, :rating, :image)
    end
end
