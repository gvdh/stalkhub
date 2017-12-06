class ResultsController < ApplicationController

  def fb_index
    @results = policy_scope(Result).order(created_at: :desc)
  end

  def fb_index_photo
    @results = policy_scope(Result).order(created_at: :desc)
    @photos = []
    @results.each do |result|
      @photos << result if result.category == "photo"
    end
  end

  def fb_index_text
  end

  def fb_index_video
  end
end
