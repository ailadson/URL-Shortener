# == Schema Information
#
# Table name: visits
#
#  id           :integer          not null, primary key
#  visitor_id   :integer          not null
#  short_url_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Visit < ActiveRecord::Base
    validates :visitor_id, presence: true
    validates :short_url_id, presence: true

    belongs_to(
      :visitor,
      class_name: "User",
      foreign_key: :visitor_id,
      primary_key: :id
    )

    belongs_to(
      :visited_url,
      class_name: "ShortenedUrl",
      foreign_key: :short_url_id,
      primary_key: :id
    )


end
