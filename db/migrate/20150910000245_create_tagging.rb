class CreateTagging < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.timestamps
      t.integer :tag_id, null: false
      t.integer :user_id, null: false
      t.integer :short_url_id, null: false
    end
  end
end
