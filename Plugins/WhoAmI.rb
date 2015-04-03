class Who
  include Cinch::Plugin

  match(/whoami/i) 
  help = "Shows authname"
  def execute(m)
    m.reply "You are " + getUser(m.user)
  end
end