class Master
  include Cinch::Plugin

  match "master" 
  help = "Shows if Master or not"
  def execute(m)
    m.reply "You " + (is_Master?(m.user) ? "are ": "are not ") + "my Master"
  end
end