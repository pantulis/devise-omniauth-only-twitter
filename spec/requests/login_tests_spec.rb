require 'spec_helper'

describe "Login integration tests" do
  it "should show a link to Twitter when not logged in " do
      visit root_path
      page.html.should match /Sign in with Twitter/
  end
  
  it "should correctly log in a user via twitter" do
    visit root_path
    click_link('twitter_login')
    page.html.should match /Hola, zapnap/
  end
  
  it "should correctly log out a user" do
    visit root_path
    click_link('twitter_login')
    page.html.should match /Hola, zapnap/
    click_link('Logout')
    page.html.should match /Sign in with Twitter/
  end
end

describe "Login specs" do
  it "should create a new user and a new authentication if the user never logged before " do
    visit root_path
    click_link('twitter_login')
    Authentication.count.should eql 1
    User.count.should eql 1
  end
  
  it "should not create a new authentication if the user logged before" do
    other_user = Factory(:user, :name => "Somebodoy", :nickname => "some")
    auth = Factory(:authentication)
    visit root_path
    click_link('twitter_login')
    Authentication.count.should eql 1
    User.count.should eql 2
  end
end
