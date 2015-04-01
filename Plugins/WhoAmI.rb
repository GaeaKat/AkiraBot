class Who
  include Cinch::Plugin

  match(/whoami/i) 
  help = "Shows authname"
  def execute(m)
    m.reply "You are #{m.user.authname}"
  end
end