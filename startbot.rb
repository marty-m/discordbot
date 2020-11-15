require 'discordrb'
require 'kimurai'
require 'capybara'
require 'httparty'
require 'clipboard'

bot = Discordrb::Bot.new token: '<your token here>'


bot.message(content: '.skribbl') do |event|

  @@message = event.respond "Please wait..."

  class Scraper < Kimurai::Base
    Capybara.register_driver :selenium_chrome do |app|
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_preference('profile.content_settings.exceptions.clipboard', {
          '*': {'setting': 1}
      })
      Capybara::Selenium::Driver.new(app, browser: :selenium_chrome, options: options)
    end
    @name = 'skribbl_scraper'
    @start_urls = ['https://skribbl.io/']
    @engine = :selenium_chrome

    def parse(response, url:, data: {})

      browser.execute_script('window.scrollBy(0,10000)')
      browser.find('//*[@id="buttonLoginCreatePrivate"]').click
      sleep 2

      browser.execute_script('window.scrollBy(0,150)')
      browser.find('//*[@id="cmpbntyestxt"]').click

      browser.find('//*[@id="inviteCopyButton"]').click
      input = browser.find('//*[@id="lobbySetCustomWords"]')
      input.base.send_keys([:control, "v"])
      $link = input.value
      @@message.edit "#{$link}"

      loop do
        sleep 1
        break if browser.has_css?("#player1") == true

      end
    end
  end
  Scraper.crawl!
end

bot.run

