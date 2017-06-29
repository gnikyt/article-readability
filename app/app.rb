require 'odyssey'
require 'nokogiri'
require 'open-uri'
require 'sinatra'
require 'slim'

# Configuration
configure do
  set :public_folder, "#{__dir__}/../public"
end

# GET /
get '/' do
  slim :index
end

# POST /
post '/' do
  # Converting readability score to a readable value
  scoring_map = [
    {
      range: (0.00..30.00),
      level: 'College Graduate',
      message: 'Very difficult to read'
    },
    {
      range: (30.00..50.00),
      level: 'College',
      message: 'Difficult to read'
    },
    {
      range: (50.00..60.00),
      level: '10th to 12th Grade',
      message: 'Fairly difficult to read'
    },
    {
      range: (60.00..70.00),
      level: '8th to 9th Grade',
      message: 'Plain english'
    },
    {
      range: (70.00..80.00),
      level: '7th Grade',
      message: 'Fairly easy to read'
    },
    {
      range: (80.00..90.00),
      level: '6th Grade',
      message: 'Easy to read'
    },
    {
      range: (90.00..100.00),
      level: '5th Grade',
      message: 'Very easy to read'
    }
  ]

  begin
    # Parse URL and selector
    url, selector = params[:url].split '@'
    url = "http://#{url}" unless url =~ %r{http|https}

    # Process the HTML
    document = Nokogiri::HTML open(url)
    paragraph = document
      .css(selector)
      .css('article', 'p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'a', 'ol', 'ul')
      .map(&:text)
      .join('. ')
      .gsub('\n', ' ')
    
    # Score the article and grab a match
    @score = Odyssey.flesch_kincaid_re paragraph, true
    @score_match = scoring_map.find do |score_map|
      score_map if score_map[:range].include?(@score['score'])
    end
  rescue
    # Error!
  end

  slim :index
end
