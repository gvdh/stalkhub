class ProviderChannel < ApplicationCable::Channel
  def subscribed
    stream_from "provider_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
