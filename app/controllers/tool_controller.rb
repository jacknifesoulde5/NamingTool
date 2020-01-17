class ToolController < ApplicationController
  def index
    @words = Word.all.to_a.uniq {|word| word.manualKind}
    @word = Word.new
  end

  #TODO: これって変換処理なのにRESTを守ってcreateに作るのか。
  #      CRUDとは違うような気がするが。
  def create
    #TODO:このように書くかは別途検討
    @words = Word.all
    @word = Word.new(conv_params)

    binding.pry

    #いずれはモデルに移した方が良いんだろうな。
    #変換後文字列生成
    conv_array =[]
    if Word.where(id: conv_params[:concreteMethod]).present?
      conv_array.push(Word.where(id: conv_params[:concreteMethod]).first["english_word"])
    end
    if Word.where(japanese_word: conv_params[:japanese_word]).present?
      conv_array.push(Word.where(japanese_word: conv_params[:japanese_word]).first["english_word"])
    end

    render json: [{"conv_word": conv_array.join('_').downcase}]
  end

  def conv_other
    #TODO:Strong Parameter的なことはしなくても良いのだろうか。
    #いずれはモデルに移した方が良いんだろうな。
    #変換後文字列生成
    conv_array =[]
    if Word.where(japanese_word: params[:word1]).present?
      conv_array.push(Word.where(japanese_word: params[:word1]).first["english_word"].downcase)
    end
    if Word.where(japanese_word: params[:word2]).present?
      conv_array.push(Word.where(japanese_word: params[:word2]).first["english_word"].downcase)
    end
    if Word.where(japanese_word: params[:word3]).present?
      conv_array.push(Word.where(japanese_word: params[:word3]).first["english_word"].downcase)
    end
    #スネークケースに変換
    conv_other = conv_array.join('_')
    render json: [{"conv_other_camel": conv_other.camelize,
                   "conv_other_downcase": conv_other,
                   "conv_other_upcase": conv_other.upcase}]
  end

  #TODO: 本当にこのメソッド名で良いのか。
  def show
    manualKind = Word.where(id: params[:id]).first["manualKind"]
    render json: Word.where(manualKind: manualKind).select(:concreteMethod,:id)
  end

  private

  def conv_params
    params.require(:word).permit(:manualKind,:concreteMethod,:japanese_word)
  end
end
