class Word < ApplicationRecord

  def self.search(search)
    where("eng LIKE ?", "#{search}") 
  end

  scope :by_range_id, -> id_from, id_to {where(id: id_from..id_to) if id_from.present? && id_to.present?}
  scope :by_first_letter, -> first_letter {where("substr(eng, 1, 1) in (#{first_letter})") if first_letter.present?}
  scope :by_latest_ids, -> end_ids {order("id desc").limit(end_ids) if end_ids.present?}

  validates :eng, :rus, :translation, presence: true
  validates :eng, uniqueness: true

end
