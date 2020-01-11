class WordsController < ApplicationController
  def index
    @words = Word.all
  end

  def new
    @word = Word.new
  end

  def create
    word = Word.new(word_params)
    if word.save
      redirect_to words_path
    end
  end

  def destroy
    word = Word.find(params[:id])
    word.delete
    head :no_content
    #redirect_to words_path
  end

  private

  def word_params
    params.require(:word).permit(:manualKind,
                                 :concreteMethod,
                                 :japanese_word,
                                 :english_word,
                                 :use)
  end

end
