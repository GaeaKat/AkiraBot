class Games
  include Cinch::Plugin

  match /game list[ ]?(\d+)?/, method: :listGames
  match /game add (.*$)/, method: :addGame
  match /game remove (\d+)/, method: :removeGame
  match /game rules (\d+)$/, method: :listRules
  match /game rules (\d+) add (.*$)/, method: :addRuleLine
  #match /game rules (\d+) remove (.*$)/, method: :removeRuleLine
  match /game rules (\d+) edit (\d+) (.*$)/, method: :editRuleLine
  def listGames(m,page)
    if(page.nil?)
      page=1
    end
      m.reply "List of Games"
      count=Game.all.count
      if(count>10)
        m.reply "Page #{page} out of #{(count/10).floor+1}"
       end
    m.reply "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    games=Game.paginate(:page => page, :per_page => 10).each_with_index do |game,index|
      m.reply "#{game.id}. #{game.name}"
    end
    m.reply "Type !game rules <number> to find out the rules for a game"
  end
  
  def addGame(m,game)
    if(!checkMaster(m))
      return
    end
    g=Game.new
    g.name=game
    g.rules=""
    g.save
    m.reply "Added game #{game}", true
  end
  def removeGame(m,game)
    if(!checkMaster(m))
      return
    end
    if(!Game.exists?(game))
      m.reply "Game #{game} not found", true
      return
    end
    g=Game.find(game)
    g.destroy
    m.reply "Removed game #{game}", true
  end
  def listRules(m,game)
    if(!Game.exists?(game))
      m.reply "Game #{game} not found", true
      return
    end
    g=Game.find(game)
    m.user.safe_notice "Rules for game #{g.name}"
    rules=g.rules.split(/\r?\n/)
    rules.each { |x| m.user.safe_notice x}
  end
  def addRuleLine(m,game,line)
    if(!checkMaster(m))
      return
    end
    if(!Game.exists?(game))
      m.reply "Game #{game} not found", true
      return
    end
    g=Game.find(game)
    if(g.rules.nil?)
      g.rules=""
    end
    g.rules="#{g.rules}\r\n#{line}"
    g.save
    m.reply "Added line."
  end
  
  def editRuleLine(m,game,lineNum,text)
    if(!checkMaster(m))
      return
    end
    if(!Game.exists?(game))
      m.reply "Game #{game} not found", true
      return
    end
    g=Game.find(game)
    if(g.rules.nil?)
      g.rules=""
    end
    rules=g.rules.split(/\r?\n/)
    rules[lineNum.to_i-1]=text
    g.rules=rules.join("\r\n")
    g.save
    m.reply "Edited line."
  end
  
end