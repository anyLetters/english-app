class RemoveFieldsFromWordsTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :words, :noun
    remove_column :words, :verb
    remove_column :words, :adverb
    remove_column :words, :adjective
    remove_column :words, :pronoun
    remove_column :words, :particle
    remove_column :words, :preposition
    remove_column :words, :conjunction
    remove_column :words, :interjection
  end
end
