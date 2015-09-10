# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  short_url    :string
#  long_url     :string           not null
#  submitter_id :integer          not null
#

require "SecureRandom"

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    primary_key: :id,
    foreign_key: :short_url_id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )

  def self.random_code
    code = SecureRandom::urlsafe_base64[0..15]

    while find_by_short_url(code)
      code = SecureRandom::urlsafe_base64[0..15]
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    create!(submitter_id: user.id, long_url: long_url, short_url: random_code)
  end

  def num_clicks
    visits.length
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visitors.where("visits.created_at > ?", 10.minutes.ago).count
  end

end
