class Word < ApplicationRecord
  def create_conv_word(conv_params)
      conv_array = []
      conv_params.each do |param|
        if Word.where(param).present?
          conv_array.push(Word.where(param).first["english_word"])
        end
      end
      conv_array.join('_').downcase
  end
end
