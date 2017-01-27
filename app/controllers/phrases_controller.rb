class PhrasesController < ApplicationController
  
  def phrase
    @phrase = Phrase.order("RANDOM()").first
    @count = Phrase.all

    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @phrase = Phrase.all
  end 

  def new
    @phrase = Phrase.new
    @count = Phrase.all
  end

  def create
    @phrase = Phrase.new(phrase_params)
    if @phrase.save
      redirect_to phrases_path
    else
      render 'new'
    end
  end

  def edit
    @phrase = Phrase.find(params[:id])
    @count = Phrase.all
  end

  def update
    @phrase = Phrase.find(params[:id])

    if @phrase.update(phrase_params)
      redirect_to phrases_index_path
    else
      render 'edit'
    end
  end

  private
    def phrase_params
      params.require(:phrase).permit(:phr_eng, :phr_rus)
    end
end
