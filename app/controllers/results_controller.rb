class ResultsController < ApplicationController

  before_action :load_results

  def index

    if @loaded_provider.nil?
      return redirect_to new_provider_path(params[:provider])
    end

    if @loaded_provider.name == "facebook"
      if @loaded_provider.expires_at <= Time.now.to_i
        current_user.providers.where(name: "facebook").destroy_all
        return redirect_to new_provider_path(params[:provider])
      end
    end

  end

  private

  def load_results
    @provider = params[:provider]
    @results = policy_scope(Result).select { |r| r.provider.name == @provider }
    @loaded_provider = Provider.where(name: params[:provider], user: current_user).last

    # check_results_size ??

    @category = params[:category]
    if params[:category] == 'photo'
      @results = @results.select { |r| r.category == "photo" }
    elsif params[:category] == 'post'
      @results = @results.select { |r| r.category == "post" }
    elsif params[:category] == 'video'
      @results = @results.select { |r| r.category == "video" }
    elsif params[:category] == 'page'
      @results = @results.select { |r| r.category == "page" }
    else
      @results
    end

    @privacy = params[:privacy]
    if params[:privacy] == 'public'
      @results = @results.select { |r| r.privacy == "EVERYONE"}
    elsif params[:privacy] == 'friends'
      @results = @results.select { |r| r.privacy == "ALL_FRIENDS"}
    elsif params[:privacy] == 'myself'
      @results = @results.select { |r| r.privacy == "SELF"}
    else
      @results
    end

    # @order = params[:order]
    # if params[:order] == 'reverse'
    #   @results = @results.sort_by!{ |r| r.created_time }
    # else
    #   @results = @results.sort_by!{ |r| r.created_time }.reverse
    # end

    @paginatable_array = Kaminari.paginate_array(@results).page(params[:page])
    @results = @paginatable_array
  end

end
