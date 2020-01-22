require 'rails_helper'

RSpec.describe Word, type: :model do
  let(:word){ FactoryBot.create(:word) }

  describe 'is invalid' do
    it 'is invalid without a japanese_word' do
      invalid_word = FactoryBot.build(:word, japanese_word: nil)
      invalid_word.valid?
      expect(invalid_word.errors.messages[:japanese_word]).to include("を入力してください")
    end

    it 'is invalid without a english_word' do
      invalid_word = FactoryBot.build(:word, english_word: nil)
      invalid_word.valid?
      expect(invalid_word.errors.messages[:english_word]).to include("を入力してください")
    end

    it 'is duplication in japanese_word and english_word' do
      invalid_word1 = word
      invalid_word2 = FactoryBot.build(:word,id: '2') 
      invalid_word2.valid?
      expect(invalid_word2.errors.messages[:english_word]).to include("はすでに存在します")
    end
  end

  describe '#create_conv_word' do
    context 'words exists in db' do
      it 'japanese_word1、japanese_word2、japanese_word3' do
        expect(word.create_conv_word(
          [{japanese_word: "日本語名"},
           {japanese_word: "日本語名"},
           {japanese_word: "日本語名"}]
           )).to eq "englishname_englishname_englishname"
      end

      it 'id、japanese_word' do
        expect(word.create_conv_word(
              [{id: "1"},
               {japanese_word: "日本語名"}]
               )).to eq "englishname_englishname"
      end

      it 'japanese_word1、japanese_word2' do
        expect(word.create_conv_word(
          [{japanese_word: "日本語名"},
           {japanese_word: "日本語名"}]
           )).to eq "englishname_englishname"
      end

      it 'id' do
        expect(word.create_conv_word(
          [{id: "1"}]
           )).to eq "englishname"
      end

      it 'japanese_word' do
        expect(word.create_conv_word(
          [{japanese_word: "日本語名"}]
           )).to eq "englishname"
      end
    end

    context 'words not exists in db' do
      it 'japanese_word1、japanese_word2、japanese_word3' do
        expect(word.create_conv_word(
          [{japanese_word: "日本語名2"},
           {japanese_word: "日本語名2"},
           {japanese_word: "日本語名2"}]
           )).to eq ""
      end

      it 'id、japanese_word' do
        expect(word.create_conv_word(
          [{id: "2"},
           {japanese_word: "日本語名2"}]
           )).to eq ""
      end

      it 'japanese_word1、japanese_word2' do
        expect(word.create_conv_word(
          [{japanese_word: "日本語名2"},
           {japanese_word: "日本語名2"}]
           )).to eq ""
      end

      it 'id' do
        expect(word.create_conv_word(
          [{id: "2"}]
           )).to eq ""
      end

      it 'japanese_word' do
        expect(word.create_conv_word(
          [{japanese_word: "日本語名2"}]
           )).to eq ""
      end
    end

  end
end
