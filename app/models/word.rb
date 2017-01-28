class Word < ApplicationRecord

  def self.search(search)
    where("eng LIKE ?", "#{search}") 
  end

  scope :by_range_id, -> id_from, id_to {where(id: id_from..id_to) if id_from.present? && id_to.present?}
  scope :by_first_letter, -> first_letter {where("substr(eng, 1, 1) in (#{first_letter})") if first_letter.present?}
  scope :by_latest_ids, -> end_ids {order("id desc").limit(end_ids) if end_ids.present?}
  # scope :by_pos, -> noun, verb, adverb, adjective, pronoun, particle, preposition, conjunction, interjection {where("noun = '#{noun}' OR verb = '#{verb}' OR adverb = '#{adverb}' OR adjective = '#{adjective}' OR pronoun = '#{pronoun}' OR particle = '#{particle}' OR preposition = '#{preposition}' OR conjunction = '#{conjunction}' OR interjection = '#{interjection}'")}

  validates :eng, :rus, :noun, :verb, :adverb, :adjective, :pronoun, :particle, :preposition, :conjunction, :interjection, :translation, presence: true
  validates :eng, uniqueness: true, presence: true

end
