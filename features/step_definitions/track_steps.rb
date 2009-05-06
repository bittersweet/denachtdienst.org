Given /^I have tracks titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Track.create!(:name => title, :mp3_file_name => "test.mp3" )
  end
end

Given /^I am logged in as an Admin$/ do
  visit login_path
  fill_in("login", :with => "admin")
  fill_in("password", :with => "password")
  click_button("Log in")
end

Then /^I should see my account details$/ do
  @user = User.find(1)
  Then "I should see \"#{@user.login}\""
  Then "I should see \"#{@user.email}\""
end

