FactoryBot.define do
  factory :word do
    id { '1' }
    manualKind { '取得する' }
    concreteMethod { 'DB' }
    japanese_word { '日本語名' }
    english_word { 'englishname' }
    use { '用途' }
  end
end