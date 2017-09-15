require 'open-uri'
require 'HTTParty'
require 'xpath'
require 'crack'
require 'gmail'

@password = 'INSERT PASSWORD'
@username = 'INSERT EMAIL'

def send_email(status,loadTime)
  @gmail = Gmail.connect(@username, @password)

  email = @gmail.compose do
    to 'Jenn.Kemp.Codes@gmail.com'

    if status.to_i == 200
     subject 'Your website is up and running!'
      body 'We have succesfully pinged your website and it is up and working with an average loadtime of ' + loadTime + 'ms'
      puts 'Success email has been sent'
    else
      subject 'Your website is not up working'
      body 'We have pinged your website and it is not functioning properly'
      puts 'Failure email has been sent'
      end
  end
  email.deliver!
end

@web_page_test_loading_results_url = 'http://www.webpagetest.org/xmlResult/170904_JM_db94ee89b80bac884269b9b857fab766/'

@page = HTTParty.get(@web_page_test_loading_results_url).to_s

@parsed_xml = Crack::XML.parse(@page)

@status_code_response = @parsed_xml['response']['statusCode']

@page_load_time = @parsed_xml ['response']['data']['average']['firstView']['loadTime']

# This is where I wait for the URL to finish testing
until @status_code_response.to_i == 200
  puts "Waiting for 200"
  sleep 10
  end

if @status_code_response.to_i == 200
  puts "Hey isn't this awesome!!! " + @status_code_response

else
  puts "still no 200...gonna' sleep for a little while :-)"
end

send_email(@status_code_response, @page_load_time)
# Gmail may block sign-in attempts from this script. You can allow access by this script by "allowing access to less secure apps"
