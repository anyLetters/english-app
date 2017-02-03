class Phrase < ApplicationRecord
  validates :phr_eng, uniqueness: true, presence: true
  validates :phr_rus, :examp, presence: true
end
