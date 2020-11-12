require 'nokogiri'
require 'kimurai'
require 'capybara'
require 'httparty'
require 'clipboard'
require 'webdrivers/chromedriver'

class SkribblScraper < Kimurai::Base
  @name = 'skribbl_scraper'
  @start_urls = ["https://skribbl.io/"]
  @engine = :selenium_chrome

  # def scrape_page
  #   doc = browser.current_response
  #
  # end

  def parse(response, url:, data: {})
    browser.find('/html/body/div[3]/div[2]/div[2]/div[1]/form/button[2]').click
    puts "Created private game..."

   browser.find('/html/body/div[3]/div[5]/div[3]/div[2]/button').click
    $link = Clipboard.paste
  end
end

skriblink = SkribblScraper.parse!(:parse, url: "https://skribbl.io/")
pp skriblink
