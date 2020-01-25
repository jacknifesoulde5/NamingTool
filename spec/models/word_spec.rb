require 'rails_helper'

RSpec.describe Word, type: :model do
  let(:word){ FactoryBot.create(:word) }

  RSpec::Matchers.define_negated_matcher :exclude, :include

  describe 'is invalid' do
    context 'invalid without' do
      it 'is invalid in japanese_word and manualKind and concreteMethod' do
        invalid_word = FactoryBot.build(:word)
        invalid_word.valid?
        expect(invalid_word.errors.messages[:manualKind]).to exclude("を入力してください")
        expect(invalid_word.errors.messages[:concreteMethod]).to exclude("を入力してください")
        expect(invalid_word.errors.messages[:japanese_word]).to exclude("を入力してください")
      end

      it 'is invalid without a manualKind and concreteMethod and japanese_word' do
        invalid_word = FactoryBot.build(:word,manualKind: "",concreteMethod: "", japanese_word: "")
        invalid_word.valid?
        expect(invalid_word.errors.messages[:manualKind]).to include("を入力してください")
        expect(invalid_word.errors.messages[:concreteMethod]).to include("を入力してください")
        expect(invalid_word.errors.messages[:japanese_word]).to include("を入力してください")
      end

      it 'is invalid without a japanese_word,in manualKind and concreteMethod' do
        invalid_word = FactoryBot.build(:word,japanese_word: "")
        invalid_word.valid?
        expect(invalid_word.errors.messages[:manualKind]).to exclude("を入力してください")
        expect(invalid_word.errors.messages[:concreteMethod]).to exclude("を入力してください")
        expect(invalid_word.errors.messages[:japanese_word]).to exclude("を入力してください")
      end

      it 'is invalid without a japanese_word and manualKind,in concreteMethod' do
        invalid_word = FactoryBot.build(:word,japanese_word: "",manualKind: "")
        invalid_word.valid?
        expect(invalid_word.errors.messages[:manualKind]).to include("を入力してください")
        expect(invalid_word.errors.messages[:concreteMethod]).to exclude("を入力してください")
        expect(invalid_word.errors.messages[:japanese_word]).to exclude("を入力してください")
      end

      it 'is invalid without a japanese_word and concreteMethod,in manualKind' do
        invalid_word = FactoryBot.build(:word,japanese_word: "",concreteMethod: "")
        invalid_word.valid?
        expect(invalid_word.errors.messages[:manualKind]).to exclude("を入力してください")
        expect(invalid_word.errors.messages[:concreteMethod]).to include("を入力してください")
        expect(invalid_word.errors.messages[:japanese_word]).to exclude("を入力してください")
      end
    end

    context 'invalid duplication' do
      it 'is duplication in manualKind and concreteMethod and japanese_word and english_word' do
        invalid_word1 = word
        invalid_word2 = FactoryBot.build(:word,id: '2') 
        invalid_word2.valid?
        expect(invalid_word2.errors.messages[:manualKind]).to include("はすでに存在します")
        expect(invalid_word2.errors.messages[:concreteMethod]).to include("はすでに存在します")
        expect(invalid_word2.errors.messages[:japanese_word]).to include("はすでに存在します")
        expect(invalid_word2.errors.messages[:english_word]).to include("はすでに存在します")
      end

      it 'is not duplication in manualKind and concreteMethod and english_word' do
        invalid_word1 = word
        invalid_word2 = FactoryBot.build(:word,id: '2',manualKind: "取得する2",japanese_word: "") 
        invalid_word2.valid?
        expect(invalid_word2.errors.messages[:manualKind]).to  exclude("はすでに存在します")
        expect(invalid_word2.errors.messages[:concreteMethod]).to exclude("はすでに存在します")
        expect(invalid_word2.errors.messages[:english_word]).to exclude("はすでに存在します")
      end

      it 'is not duplication in manualKind and concreteMethod and english_word' do
        invalid_word1 = word
        invalid_word2 = FactoryBot.build(:word,id: '2',concreteMethod: "DB2",japanese_word: "") 
        invalid_word2.valid?
        expect(invalid_word2.errors.messages[:manualKind]).to exclude("はすでに存在します")
        expect(invalid_word2.errors.messages[:concreteMethod]).to exclude("はすでに存在します")
        expect(invalid_word2.errors.messages[:english_word]).to exclude("はすでに存在します")
      end

      it 'is not duplication in japanese_word and english_word' do
        invalid_word1 = word
        invalid_word2 = FactoryBot.build(:word,id: '2',japanese_word: "日本語名2",manualKind: "取得する2",concreteMethod: "DB2") 
        invalid_word2.valid?
        expect(invalid_word2.errors.messages[:japanese_word]).to exclude("はすでに存在します")
        expect(invalid_word2.errors.messages[:english_word]).to exclude("はすでに存在します")
      end
    end
  end

  describe '#create_conv_word' do
    context 'create_conv_word' do
      it 'exists in db' do
        expect(word.create_conv_word({japanese_word: "日本語名"})).to eq "englishname"
      end

      it 'not exists in db' do
        expect(word.create_conv_word({japanese_word: "日本語名2"})).to eq nil
      end
    end

    context 'create_conv_multifilter_word' do
      it 'exists in db' do
        expect(word.create_conv_multifilter_word({manualKind: "取得する",concreteMethod: "DB"})).to eq "englishname"
      end

      it 'not exists in db' do
        expect(word.create_conv_multifilter_word({manualKind: "取得する2",concreteMethod: "DB2"})).to eq nil
      end

      it 'not exists in db(only manualKind)' do
        expect(word.create_conv_multifilter_word({manualKind: "取得する",concreteMethod: "DB2"})).to eq nil
      end

      it 'not exists in db(only concreteMethod)' do
        expect(word.create_conv_multifilter_word({manualKind: "取得する2",concreteMethod: "DB"})).to eq nil
      end
    end
  end
end
