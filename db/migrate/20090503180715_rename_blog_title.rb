class RenameBlogTitle < ActiveRecord::Migration
  def self.up
    rename_column :blogs, :title, :owner_name
  end

  def self.down
    rename_column :blogs, :owner_name, :title
  end
end
