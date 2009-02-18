class TracksController < ApplicationController
  def index
    @track = Track.find(:all)
  end

  def new
    @track = Track.new
  end

end
