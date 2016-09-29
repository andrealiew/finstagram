# We run this file by "bundle exec rake db:migrate" in console
# This file helps us build/modify our database schema
# ActiveRecord is an ORM migrations allows us to use Ruby language instead of SQL

class CreateBaseTables < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.string :username
      t.string :avatar_url
      t.string :email
      t.string :password
      t.timestamps
    end

    create_table :posts do |t|
      t.references :user
      t.string :photo_url
      t.timestamps
    end

    create_table :comments do |t|
      t.references :user
      t.references :post
      t.text :text
      t.timestamps
    end

    create_table :likes do |t|
      t.references :user
      t.references :post
      t.timestamps
    end

  end

end