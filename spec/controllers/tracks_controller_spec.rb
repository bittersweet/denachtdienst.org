require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TracksController, "when creating a new track" do
  
  before( :each ) do
    @track = Track.new
  end
  
  it "should not be valid without a name" do
    @track.should_not be_valid
  end
  
  it "should not be valid with a name but without a track" do
    @track.name = "testtrack"
    @track.should_not be_valid
  end

  it "should not be valid with a track but without a name" do
    @track = Track.new(:mp3 => fixture_file_upload('dilla.mp3', 'audio/mpeg'))
    @track.stub!(:save_attached_files).and_return true
    @track.save.should_not be_true
  end

  it "should not be valid with a name and track but without a user id" do
    @track = Track.new(:name => "test", :mp3 => fixture_file_upload('dilla.mp3', 'audio/mpeg'))
    @track.stub!(:save_attached_files).and_return true
    @track.save.should_not be_true
  end
  
  it "should be valid with a name, track and user id" do
    @track = Track.new(:name => "test", :user_id => "1", :mp3 => fixture_file_upload('dilla.mp3', 'audio/mpeg'))
    @track.stub!(:save_attached_files).and_return true
    @track.save.should be_true
  end

end
