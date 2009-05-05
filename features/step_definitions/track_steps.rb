Given /^I have tracks titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    Track.create!(:name => title, :mp3 => File.join(RAILS_ROOT, 'features', 'upload-files', 'track.mp3') )
    # Track.create!(:name => title, :user_id => "1")
  end
end
