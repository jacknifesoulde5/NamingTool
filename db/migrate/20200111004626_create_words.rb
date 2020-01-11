class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :manualKind
      t.string :concreteMethod
      t.string :japanese_word
      t.string :english_word
      t.text :use

      t.timestamps
    end
  end
end
