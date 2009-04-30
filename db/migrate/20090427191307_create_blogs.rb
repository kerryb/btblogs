class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string :title, :owner_email, :html_uri, :feed_uri
    end
  end

  def self.down
  end
end
