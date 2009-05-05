class AddConfirmedToBlogs < ActiveRecord::Migration
  def self.up
    add_column :blogs, :confirmed, :boolean
  end

  def self.down
    remove_column :blogs, :confirmed
  end
end
