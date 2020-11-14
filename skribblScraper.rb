require 'kimurai'
require 'capybara'
require 'httparty'
require 'clipboard'


class BigScraper < Kimurai::Base
  @name = 'skribbl_scraper'
  @start_urls = ["https://skribbl.io/"]
  @engine = :selenium_chrome



  def parse(response, url:, data: {})
    browser.execute_script("window.scrollBy(0,10000)")
    browser.find('//*[@id="buttonLoginCreatePrivate"]').click
    puts "Created private game..." ; sleep 4

    browser.execute_script("window.scrollBy(0,10000)")
    doc = browser.current_response
    #linkvalue = doc
    linkvalue = browser.find('//*[@id="screenLobby"]/div[3]/div[2]/div').hover
    puts linkvalue
  end
end

skribbllink = BigScraper.crawl!

