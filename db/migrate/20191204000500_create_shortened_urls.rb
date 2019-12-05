class CreateShortenedUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :shortened_urls do |t|
      t.text :original_url, null: false
      t.text :sanitized_original_url, null: false
      t.string :shortened_url_token, null: false

      t.timestamps
    end
  end
end
