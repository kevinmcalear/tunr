class PlaylistUser < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :user

  validates :playlist, :user, presence: true
  validate :shares_playlist_with_correct_user

  private

  def shares_playlist_with_correct_user
    return unless playlist && user
    unless playlist.user == user
      errors.add(:playlist, "You can't view playlist!")
    end
  end
end