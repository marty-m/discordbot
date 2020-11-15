require 'kimurai'
require 'capybara'
require 'httparty'
require 'clipboard'


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

  def scrape_link
    #browser.execute_script(';.grantPermissions', origin: browser.server_url, permissions: ['clipboardReadWrite'])
    browser.save_screenshot('screen.png', full: true)
    File.open("/tmp/log.txt", "w") do |f| f.write "#{Time.now} ----------------------
#{browser.html}
--------------------------------------------------------



"
    end
    browser.execute_script('window.scrollBy(0,150)')

    browser.find('//*[@id="cmpbntyestxt"]').click

    browser.save_screenshot('screen.png', full: true)

    browser.find('//*[@id="inviteCopyButton"]').click
    input = browser.find('//*[@id="lobbySetCustomWords"]')
    input.base.send_keys([:control, "v"])

    browser.save_screenshot('screen.png', full: true)

    $link = input.value
    puts $link
  end

  def parse(response, url:, data: {})
    #browser.execute_cdp('Browser.grantPermissions', origin: page.server_url, permissions: ['clipboardReadWrite'])
    browser.execute_script('window.scrollBy(0,10000)')
    browser.find('//*[@id="buttonLoginCreatePrivate"]').click
    puts 'Created private game...' ; sleep 2

    scrape_link
    quit_on_join
  end

  def quit_on_join
    loop do
      sleep 1
      break if browser.has_css?("#player1") == true
    end
  end
end



