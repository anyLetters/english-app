class DropWordNetTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :word_nets
  end
end
