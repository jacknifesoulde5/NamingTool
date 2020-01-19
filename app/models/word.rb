class Word < ApplicationRecord
  validates :japanese_word,presence: true,uniqueness: { scope: :english_word  }
  validates :english_word,presence: true,uniqueness: { scope: :japanese_word  }

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
