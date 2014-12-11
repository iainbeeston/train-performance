class RtppmSnapshot < ActiveRecord::Base
  extend Memoist

  scope :most_recent, -> { order(imported_at: :desc) }

  def operator_performance
    raw_data.values.first['RTPPMData']['OperatorPage'].map do |operator|
      OperatorPerformance.new(RtppmOperatorPerformanceMapper.normalize(operator))
    end
  end
  memoize :operator_performance

  def self.up_to_date?
    most_recent.pluck(:imported_at).first >= 10.minutes.ago
  end

  def self.import
    client = StompClient.new(username: ENV['NETWORK_RAIL_USERNAME'], password: ENV['NETWORK_RAIL_PASSWORD'], host: 'datafeeds.networkrail.co.uk', port: 61618, topic: "/topic/RTPPM_ALL")
    data = JSON.parse(client.get)
    RtppmSnapshot.create(raw_data: data, imported_at: Time.now)
  end
end
