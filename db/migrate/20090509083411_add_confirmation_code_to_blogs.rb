class AddConfirmationCodeToBlogs < ActiveRecord::Migration
  def self.up
    add_column :blogs, :confirmation_code, :string
  end

  def self.down
    remove_column :blogs, :confirmation_code
  end
end
