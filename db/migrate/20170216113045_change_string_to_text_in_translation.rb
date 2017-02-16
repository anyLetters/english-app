class ChangeStringToTextInTranslation < ActiveRecord::Migration[5.0]
  def change
    change_column :words, :translation, :text
  end
end