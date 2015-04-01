def is_Master?(m)
  $botconfiguration['bot']['masters'].include? m.authname
end


def checkMaster(m)
  if(!is_Master? m.user)
      m.reply "I'm sorry, but you don't have the proper authority to use that command."
      false
    else
      true
    end
end

def getName(user)
  name=user.nick
    if(user.authed?)
      name=user.authname
    end
end
