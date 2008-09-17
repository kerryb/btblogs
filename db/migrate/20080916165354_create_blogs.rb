class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string :html_uri, :feed_uri
    end
  end

  def self.down
    drop_table :blogs
  end
end
