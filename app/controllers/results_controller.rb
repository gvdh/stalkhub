class ResultsController < ApplicationController

  def index
    @results = policy_scope(Result).order(created_at: :desc)
  end

  def index_photo
    @results = policy_scope(Result).order(created_at: :desc)
    @photos = []
    @results.each do |result|
      @photos << result if result.category == "photo"
    end
  end

  def index_text
  end

  def index_video
  end
end
