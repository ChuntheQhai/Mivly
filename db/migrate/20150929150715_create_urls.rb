class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
	  t.string :original_url
	  t.string :unique_key
      t.timestamps null: false
    end
  end
end
