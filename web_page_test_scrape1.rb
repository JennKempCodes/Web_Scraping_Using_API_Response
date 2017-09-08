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

@web_page_test_loading_results_url = 'http://www.webpagetest.org/xmlResult/170904_JM_db94ee89b80bac884269b9b857fab766/'

@page = HTTParty.get(@web_page_test_loading_results_url).to_s

@parsed_xml = Crack::XML.parse(@page)

@status_code_response = @parsed_xml['response']['statusCode']

# This is where I wait for the URL to finish testing
until @status_code_response.to_i == 200
  puts "Waiting for 200"
  sleep 10
  end

if @status_code_response.to_i == 200
  puts "Hey Josh isn't this awesome!!! " + @status_code_response

else
  puts "still no 200...gonna' sleep for a little while :-)"
end

#begin parse for value #loadTime

# @parse_page.get('loadTime').text

#begin email send
