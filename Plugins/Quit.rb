class Quit
  include Cinch::Plugin

  match "quit" 
  help = "I Will quit the bot"
  def execute(m)
    if(!checkMaster(m))
      return
    end
    $bot.quit("Well, please excuse me. I have deliveries to make.")
  end
end