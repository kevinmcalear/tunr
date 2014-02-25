require 'spec_helper'

describe "#######" do
  let(:owner) do 
    User.create!({
      email: "j@k.co",
      password: "jeff",
      password_confirmation: "jeff",
      first_name: "Jeff",
      last_name: "K",
      dob: Date.today,
      balance: 100.00
    })
    end

    let(:user_with_access) do 
    User.create!({
      email: "jp@k.co",
      password: "jeffp",
      password_confirmation: "jeffp",
      first_name: "Jeff P",
      last_name: "K",
      dob: Date.today,
      balance: 100.00
    }) 
    end

    let(:user_without_access) do 
    User.create!({
      email: "jd@k.co",
      password: "jeffd",
      password_confirmation: "jeffd",
      first_name: "Jeff D",
      last_name: "K",
      dob: Date.today,
      balance: 100.00
    })  
  end
    let(:playlist) { Playlist.create!(title: "Sweet Beats", user: owner)}

 

  it "shares a playlist" do
    # Owner Logs In
    login(owner)
    playlist
    user_with_access
    user_without_access

    # Add A User To The Playlist
    visit user_path(owner)
    # binding.pry
    # save_and_open_page
    click_link "Share Playlist"

    select user_with_access.first_name, from: "playlists_user"
    click_button "Share"

    # Expectations
    visit playlist_path(playlist)
    within ".playlist" do
      expect(page).to have_content "Sweet Beats"
    end
    logout(owner)
  end

  

   it "creates a playlist" do
    # Owner Logs In
    login(user_with_access)

    # Expectations
    within ".playlist" do
      expect(page).to have_content "Sweet Beats"    
    end
    logout(user_with_access)
  end



   it "creates a playlist" do
    # Owner Logs In
    login(user_without_access)

    # Expectations
    within ".playlist" do
      expect(page).to_not have_content "Sweet Beats"
    end
  end

  def login(user)
    visit "/login"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log in!"
  end

  def logout(user)
    visit "/login"
    click_link "Log Out #{user.first_name}!"
  end
end