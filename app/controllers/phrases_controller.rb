class PhrasesController < ApplicationController
  
  def phrase
    @phrase = Phrase.order("RANDOM()").first
    @count = Phrase.all

    @date = @phrase.created_at.to_date.to_s.split('-')
    m = {'01' => 'January', '02' => 'February', '03' => 'March', '04' => 'April', '05' => 'May', '06' => 'June', '07' => 'July', '08' => 'August', '09' => 'September', '10' => 'October', '11' => 'November', '12' => 'December'}
    m = m.select{|key| key == @date[1]}
    @date[1] = m.first[1]
    @date.slice!(2)

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
      params.require(:phrase).permit(:phr_eng, :phr_rus, :examp)
    end
end
