# == Schema Information
#
# Table name: taggings
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  tag_id       :integer          not null
#  user_id      :integer          not null
#  short_url_id :integer          not null
#

class Tagging < ActiveRecord::Base
  validate :not_already_tagged_by_user

  belongs_to(
    :user,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id
  )

  belongs_to(
    :tag_topic,
    class_name: "TagTopic",
    primary_key: :id,
    foreign_key: :tag_id
  )

  belongs_to(
    :short_url,
    class_name: "ShortenedUrl",
    primary_key: :id,
    foreign_key: :short_url_id
  )

  private
  def not_already_tagged_by_user
    if Tagging.exists?(short_url_id: short_url_id, user_id: user_id)
      errors[:base] << "You've taggged this video already."
    end
  end
end
