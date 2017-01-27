class Phrase < ActiveRecord::Base
  validates :phr_eng, uniqueness: true, presence: true
end
