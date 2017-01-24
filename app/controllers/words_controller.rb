class WordsController < ApplicationController

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

    @count = Word.all

    if params[:search]
      res = Word.search(params[:search])
      @word = res.first
    end

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
    @count = Word.all
  end

  def create
    @word = Word.new(word_params)
   
    #request to yandex and getting json
    require 'net/https'
    require 'openssl'
    require 'open-uri'
    api = 'dict.1.1.20161212T091712Z.d11b1c913980aac3.5b44c16cdb6cdf672f61d26a6ec8dfa9baf31b0c'
    text = @word.eng
    uri = URI.parse('https://dictionary.yandex.net/api/v1/dicservice.json/lookup')
    param = { :key => api, :lang => 'en-ru', :text => text }
    uri.query = URI.encode_www_form(param)
    http = Net::HTTP.new(uri.host, uri.port, 'Content-Type' => 'application/json')
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
    response = Net::HTTP.get(uri)
    json_response = JSON.parse response
    
    part_of_speech = []
    translation = {}
    rus = json_response['def'][0]['tr'][0]['text']
    
    noun = []
    verb = []
    adjective = []
    adverb = []
    pronoun = []
    particle = []
    preposition = []
    conjunction = []
    interjection = []

    json_response['def'].each do |i|
      part_of_speech.push(i['pos'])
        i['tr'].each do |i|
          if i['pos'] == 'noun'
            noun.push(i['text'])
            translation[:noun] = noun
          end
          if i['pos'] == 'verb'
            verb.push(i['text'])
            translation[:verb] = verb
          end
          if i['pos'] == 'adverb'
            adverb.push(i['text'])
            translation[:adverb] = adverb
          end
          if i['pos'] == 'adjective'
            adjective.push(i['text'])
            translation[:adjective] = adjective
          end
          if i['pos'] == 'pronoun'
            pronoun.push(i['text'])
            translation[:pronoun] = pronoun
          end
          if i['pos'] == 'particle'
            particle.push(i['text'])
            translation[:particle] = particle
          end
          if i['pos'] == 'preposition'
            preposition.push(i['text'])
            translation[:preposition] = preposition
          end
          if i['pos'] == 'conjunction'
            conjunction.push(i['text'])
            translation[:conjunction] = conjunction
          end
          if i['pos'] == 'interjection'
            interjection.push(i['text'])
            translation[:interjection] = interjection
          end
        end
    end

    part_of_speech.each do |i|
      if i == 'noun' 
        noun = 'yes'
      end 
      if i == 'verb' 
        verb = 'yes'
      end 
      if i == 'adverb' 
        adverb = 'yes'
      end 
      if i == 'adjective' 
        adjective = 'yes'
      end 
      if i == 'pronoun' 
        pronoun = 'yes'
      end 
      if i == 'particle' 
        particle = 'yes'
      end  
      if i == 'preposition' 
        preposition = 'yes'
      end 
      if i == 'conjunction' 
        conjunction = 'yes'
      end 
      if i == 'interjection' 
        interjection = 'yes'
      end 
    end

    if noun.empty? 
      noun = 'no'
    end

    if verb.empty? 
      verb = 'no'
    end

    if adverb.empty? 
      adverb = 'no'
    end

    if adjective.empty? 
      adjective = 'no'
    end

    if pronoun.empty? 
      pronoun = 'no'
    end

    if particle.empty? 
      particle = 'no'
    end

    if preposition.empty? 
      preposition = 'no'
    end

    if conjunction.empty? 
      conjunction = 'no'
    end

    if interjection.empty? 
      interjection = 'no'
    end

    @word = Word.new({ 'eng' => @word.eng.downcase, 'rus' => rus, 'noun' => noun, 'verb' => verb, 'adverb' => adverb, 'adjective' => adjective, 'pronoun' => pronoun, 'particle' => particle, 'preposition' => preposition, 'conjunction' => conjunction, 'interjection' => interjection, 'translation' => translation })

    if @word.save
      redirect_to word_path(@word)
    else
      render 'new'
    end
  end
  
  def show
    @word = Word.find(params[:id])
    @count = Word.all

    #request to yandex and getting json
    require 'net/https'
    require 'openssl'
    require 'open-uri'
    api = 'dict.1.1.20161212T091712Z.d11b1c913980aac3.5b44c16cdb6cdf672f61d26a6ec8dfa9baf31b0c'
    text = @word.eng
    uri = URI.parse('https://dictionary.yandex.net/api/v1/dicservice.json/lookup')
    param = { :key => api, :lang => 'en-ru', :text => text }
    uri.query = URI.encode_www_form(param)
    http = Net::HTTP.new(uri.host, uri.port, 'Content-Type' => 'application/json')
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
    response = Net::HTTP.get(uri)
    json_response = JSON.parse response

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
    @count = Word.all
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
      params.require(:word).permit(:eng, :rus, :noun, :verb, :adverb, :adjective, :pronoun, :particle, :preposition, :conjunction, :interjection, :translation)
    end
end
