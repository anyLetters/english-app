class Phrase < ApplicationRecord
  validates :phr_eng, uniqueness: true, presence: true
  validates :phr_rus, presence: true
end
