class GoogleJob < ApplicationJob
  queue_as :default

  def perform(full_name, user_id, user_ip, country_code)
    gglit = ScrapingGoogle.new(full_name, user_id, user_ip, country_code)
    gglit.basic_search
    gglit.search_with_city
  end

end
