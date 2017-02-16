class WordsController < ApplicationController

  include YandexDictionary

  has_scope :by_range_id, :using => [:id_to, :id_from], only: :word, :type => :hash
  has_scope :by_first_letter, :using => :first_letter, only: :word, :type => :hash
  has_scope :by_latest_ids, :using => :end_ids, only: :word, :type => :hash

  def word
    offset = params[:offset].present? && params[:offset].to_i > 0 ? params[:offset] : 0

    if params[:id_from].blank? && params[:id_to].blank? && params[:first_letter].blank? && params[:end_ids].blank?
      @word = Word.order("RANDOM()").first
    else
      words = apply_scopes(Word.by_range_id(params[:id_from], params[:id_to]).by_first_letter(params[:first_letter]).by_latest_ids(params[:end_ids])).all
      if params[:offset].to_i == words.length
        params[:offset] = 0
      end
      @word = words.offset(params[:offset].to_i).limit(1).first
    end

    @count = Word.all.length

    if params[:search]
      res = Word.search(params[:search])
      @word = res.first
    end

    @date = @word.created_at.to_date.to_s.split('-')
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
    @words = Word.all
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)

    json_response = translate(@word.eng)
    
    if json_response['def'].present?
      rus = json_response['def'][0]['tr'][0]['text']

      translation = {}

      words = []

      json_response['def'].each do |i|
        i['tr'].each do |i|
          word_part = i['pos'].to_sym
          translation[word_part] = words.push(i['text'])
        end
        words = []
      end
    end

    @word = Word.new({ 'eng' => @word.eng.downcase, 'rus' => rus, 'translation' => translation })

    if @word.save
      redirect_to word_path(@word)
    else
      render 'new'
    end
  end
  
  def show
    @word = Word.find(params[:id])
    @count = Word.all.length
    @translation = JSON.parse(@word.translation.gsub(':','"').gsub('=>','":'))

    json_response = translate(@word.eng)

    res = []
    @examples = []

    json_response['def'].each do |i|
      i['tr'].each do |i|
        res.push(i['ex'])
      end
    end

    res.delete(nil)
    res = res.flatten(1)

    res.each do |i|
      @examples.push(i['text'])
    end
  end
  
  def edit
    @word = Word.find(params[:id])
    @count = Word.all.length
  end
  
  def update
    @word = Word.find(params[:id])

    if @word.update(word_params)
      redirect_to words_index_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    redirect_to words_index_path
  end

  private
    def word_params
      params.require(:word).permit(:eng, :rus, :translation)
    end
end