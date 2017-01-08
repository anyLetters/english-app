class createWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string    :eng
      t.string    :rus
      t.string    :noun
      t.string    :verb
      t.string    :adverb
      t.string    :adjective
      t.string    :pronoun
      t.string    :particle
      t.string    :preposition
      t.string    :conjunction
      t.string    :interjection
      t.string    :translation
      t.timestamps null: false
    end
  end
end
