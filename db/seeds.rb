# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env = "development"
  # 大量データ投入
  # (1..50).each do |i|
  #   Word.create(manualKind: "取得する#{i}",
  #               concreteMethod: "DB#{i}",
  #               japanese_word: "日本語名#{i}",
  #               english_word: "englishName#{i}",
  #               use: "用途#{i}",
  #             )
  # end

  (1..5).each do |i|
    Word.create(manualKind: "取得する#{i}",
                concreteMethod: "DB#{i}",
                japanese_word: "日本語名#{i}",
                english_word: "englishName#{i}",
                use: "用途#{i}",
              )
  end
end