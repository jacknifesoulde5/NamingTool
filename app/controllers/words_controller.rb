class WordsController < ApplicationController
  before_action :set_word, only: [:update, :edit, :destroy]

  def index
    @q = Word.ransack(params[:q])
    @words = @q.result(distinct: true).page(params[:page])
  end

  def edit
  end

  def update
    if @word.update(word_params)
      redirect_to words_path, flash: { notice: "「#{@word.japanese_word}」の単語更新を実施しました。"}
    else
      redirect_back fallback_location: new_word_path, flash: {
        word: @word,
        error_messages: @word.errors.full_messages
      }
    end
  end  

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      redirect_to words_path, flash: { notice: "「#{@word.japanese_word}」の単語作成を実施しました。"}
    else
      redirect_back fallback_location: new_word_path, flash: {
        word: @word,
        error_messages: @word.errors.full_messages
      }
    end
  end

  def destroy
    @word.delete
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

    def set_word
      @word = Word.find(params[:id])
    end
end
