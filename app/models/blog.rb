class Blog < ApplicationRecord
  has_rich_text :content
  # A article can have a cover image
  has_one_attached :cover_image
  # link the article to a user
  belongs_to :user

  # set up scopes for sorted, scheduled, published, and draft
  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_last).order(updated_at: :desc) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  # helper methods for schduled, published, and draft
  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

  def status
    draft? ? "Draft" : scheduled? ? "Scheduled" : published? ? "Published" : "Unknown"
  end
end
