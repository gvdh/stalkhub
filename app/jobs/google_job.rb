class GoogleJob < ApplicationJob
  queue_as :default

  def perform(full_name, user_id, user_ip, country_code, provider_id)
    gglit = ScrapingGoogle.new(full_name, user_id, user_ip, country_code, provider_id)
    gglit.basic_search
    gglit.search_with_city
  end

end
