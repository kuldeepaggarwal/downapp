module Api
  module V1
    class FlightsController < BaseController
      def index
        flights = FlightsService.fetch_all('https://gist.githubusercontent.com/bgdavidx/132a9e3b9c70897bc07cfa5ca25747be/raw/8dbbe1db38087fad4a8c8ade48e741d6fad8c872/gistfile1.txt')
        attrs = params.permit(:max_distance, :max_duration, :min_duration, :max_date, :min_date, preferences: [])
                      .merge(flights: flights)

        filtered_flights = FlightPreference.new(attrs).apply!
        render json: filtered_flights.sort_by(&:score)
      end
    end
  end
end
