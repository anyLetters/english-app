class AddExampleToPhrases < ActiveRecord::Migration[5.0]
  def change
    add_column :phrases, :examp, :string
  end
end
