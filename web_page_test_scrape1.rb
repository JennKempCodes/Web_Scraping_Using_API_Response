#require 'nokogiri'
require 'open-uri'
require 'HTTParty'
require 'xpath'
require 'crack'

# @parse_page = []
# [] = Array.new
@status_return = 'statusCode'

@password = 'PASSWORD'
@username = 'EMAIL'

# Hyperium Login screen test

@web_page_test_loading_results_url = 'http://www.webpagetest.org/xmlResult/170904_JM_db94ee89b80bac884269b9b857fab766/'

@page = HTTParty.get(@web_page_test_loading_results_url).to_s

if Crack::XML.parse(['response']['statusCode'.to_i]) == 200
  @parse_page.get('loadTime').text

else sleep(10).
end
