class PlaylistsUserController < ActionController::Base
 

  def new
    @playlist = Playlist.find_by(id: params[:playlist_id])
  end

  def create
   
  end

   private


end