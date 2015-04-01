class WatchUser
  include Cinch::Plugin

  listen_to :join, method: :onJoin
  match /lastseen (\S+)/, method: :lastSeen
  match /.*/, use_prefix: false
  def execute(m)
    updateActivity(m)
  end
  def onJoin(m)
    unless m.user==$bot
      updateActivity(m)
      user=User.getUserFromUser(m.user)
      rulesMod= Rule.getLatestRule
      rulesLast=rulesMod.last
      if(user.sawrules.nil?)
        m.reply "Hello, #{m.user.nick}, and welcome to #triggerplay. Please read the !rules and follow them. I hope you enjoy your stay." # If you would like to make a profile, type !setup.
        return  
      end
      if(user.sawrules < rulesLast.updated_at)
        m.reply "Welcome back to #triggerplay #{m.user.nick}. There have been new !rules implemented since you were last here, so please read them carefully." # If you would like to make a profile, type !setup.
      end
    end
  end
  
  def lastSeen(m,userName)
    name=getName(User(userName))
    user=User.find_by(name: name)
    if(user.nil?)
      m.reply "#{userName} has not been seen by me",true
    else
      m.reply "#{userName} was last seen on #{user.lastseen} as #{user.lastas}"
    end
  end
  
  def updateActivity(m)
    user=User.getUserFromUser(m.user)
    user.lastas=m.user.nick
    user.lastseen=DateTime.now
    user.save
  end
end