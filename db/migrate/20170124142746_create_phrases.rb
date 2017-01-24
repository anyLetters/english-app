class CreatePhrases < ActiveRecord::Migration[5.0]
  def change
    create_table :phrases do |t|
      t.string :phr_eng
      t.string :phr_rus

      t.timestamps
    end
  end
end
