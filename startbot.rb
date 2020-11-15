require_relative 'skribblScraper'
require 'discordrb'

bot = Discordrb::Bot.new token: 'NzY3NDA3MzgzODkwNjI0NTEz.X4xd0g.SdSzuqlv8bDPo-zrzE8evAlbqPs'

bot.message(content: '.skribbl') do |event|

  m = event.respond("#{$link}")

end

bot.run

