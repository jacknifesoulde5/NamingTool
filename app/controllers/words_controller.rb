class WordsController < ApplicationController
  def index
    @q = Word.ransack(params[:q])
    @words = @q.result(distinct: true).page(params[:page])
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    word = Word.find(params[:id])
    if word.update(word_params)
      redirect_to words_path
    end
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
