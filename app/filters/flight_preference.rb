class Kilometers < Virtus::Attribute
  def coerce(value)
    value.to_i * 1.60934
  end
end

class Seconds < Virtus::Attribute
  def coerce(value)
    value.to_i * 3600.0
  end
end

class FlightPreference
  include Virtus.model

  attribute :flights, Array[::Flight]
  attribute :preferences, Array[String]
  attribute :min_date, Date, default: nil
  attribute :max_date, Date, default: nil
  attribute :min_duration, Seconds, default: nil
  attribute :max_duration, Seconds, default: nil
  attribute :max_distance, Kilometers, default: nil

  attribute :result, Array[::Flight]
  attribute :processed, Boolean, default: false

  def apply!
    return result if processed

    self.result = flights
    filter_by_min_duration!
    filter_by_max_duration!
    filter_by_distance!
    filter_by_carrier!
    self.processed = true
    result
  end

  private

    def filter_by_min_duration!
      return unless min_duration

      self.result = result.select do |flight|
        flight.duration >= min_duration
      end
    end

    def filter_by_max_duration!
      return unless max_duration

      self.result = result.select do |flight|
        flight.duration <= max_duration
      end
    end

    def filter_by_distance!
      return unless max_distance

      self.result = result.select do |flight|
        flight.distance <= max_distance
      end
    end

    def filter_by_carrier!
      return if preferences.blank?

      self.result = result.select do |flight|
        preferences.include?(flight.carrier)
      end
    end
end
