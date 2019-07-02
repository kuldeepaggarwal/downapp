class Flight
  CARRIER_PREF_MULTIPLIER = 0.9

  # returns KM
  def self.distance_between(source:, destination:)
    @distance ||= {}
    @distance[[source, destination]] ||= \
      (
        find_location_factor(source) *
        find_location_factor(destination)
      )
  end

  def self.find_location_factor(location)
    @factors ||= {}
    @factors[location] ||= rand(100)
  end

  include Virtus.model

  attribute :departure_time, Time
  attribute :arrival_time, Time
  attribute :carrier, String
  attribute :origin, String
  attribute :destination, String

  def duration
    @duration ||= (arrival_time - departure_time)
  end

  def distance
    self.class.distance_between(source: origin, destination: destination)
  end

  def score
    (duration * CARRIER_PREF_MULTIPLIER) + distance
  end
end
