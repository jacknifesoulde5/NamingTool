class Word < ApplicationRecord
  validates :manualKind,presence: true, if: :check_manualKind_concreteMethod?
  validates :concreteMethod,presence: true, if: :check_manualKind_concreteMethod?
  validates :japanese_word,presence: true,if: :check_japanese_word?

  validates :manualKind,uniqueness: { scope: [:concreteMethod,:english_word],message:"はすでに存在します" }
  validates :concreteMethod,uniqueness: { scope: [:manualKind,:english_word],message:"はすでに存在します" }
  validates :japanese_word,uniqueness: { scope: :english_word  },if: :exist_japanese_word?
  validates :english_word,presence: true,uniqueness: { scope: :japanese_word  }

  def create_conv_word(conv_params)
      if Word.where(conv_params).present?
        Word.where(conv_params).first["english_word"].downcase
      end
  end

  def create_conv_multifilter_word(conv_params)
    if Word.where(conv_params).present?
      Word.where(conv_params).first["english_word"].downcase
    end
  end

  private
    def check_japanese_word?
      return true if manualKind == "" && concreteMethod == ""
      false
    end

    def exist_japanese_word?
      return true if japanese_word != ""
      false
    end

    def check_manualKind_concreteMethod?
      if japanese_word == ""
        return false if manualKind != "" && concreteMethod != ""
        return true
      end
      false
    end

end
