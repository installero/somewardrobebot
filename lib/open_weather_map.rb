module OpenWeatherMap
  # Никогда не храните токены/пароли/ключи в репозитории
  APPID = 'e809fbd81e2a508842b45ad0a5c8bbc9'
  API_URL = 'http://api.openweathermap.org/data/2.5/weather'
  UNITS = 'metric'

  def self.current_weather(city)
    url = "#{API_URL}?q=#{city}&appid=#{APPID}&units=#{UNITS}"
    uri = URI(URI::encode(url))

    response = Net::HTTP.get(uri)

    JSON.parse(response, symbolize_names: true)
  end
end
