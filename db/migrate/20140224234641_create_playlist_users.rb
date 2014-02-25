class CreatePlaylistUsers < ActiveRecord::Migration
  def change
    create_table :playlist_users do |t|
      t.references :playlist
      t.references :user
    end
  end
end
