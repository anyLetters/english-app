class Phrase < ApplicationRecord
  validates :phr_eng, uniqueness: true, presence: true
end
