class FlightsService
  def self.fetch_all(url, adapter = :http)
    return to_enum(:fetch_all, url, adapter) unless block_given?
    klass = "#{adapter.to_s.classify}Adapter".constantize
    klass.fetch(url).each do |flight_details|
      yield Flight.new(flight_details.transform_keys(&:underscore))
    end
  end
end
