# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  tag        :string
#

class TagTopic < ActiveRecord::Base

  has_many(
    :taggings,
    primary_key: :id,
    foreign_key: :tag_id,
    class_name: "Tagging"
  )

  has_many(
    :tagged_urls,
    through: :taggings,
    source: :short_url
  )

  def most_popular(n)
    tagged_urls(true).
      select("shortened_urls.long_url").
      joins("LEFT OUTER JOIN visits ON shortened_urls.id = visits.short_url_id").
      group("shortened_urls.id").
      order("COUNT(visits.*) DESC").
      limit(n)
  end

end
