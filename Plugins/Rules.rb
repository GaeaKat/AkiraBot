class Rules
  include Cinch::Plugin

  match(/rules edit (\d+) (.*$)/, method: :editLine)
  match(/rules append (.*$)/, method: :appendLine)
  match(/rules prepend (.*$)/, method: :prependLine) 
  match "rules", method: :readRules
  match "rules list", method: :listRules
  help = "Edits a line"
  
  def editLine(m,lineNum,text)
    if(!checkMaster(m))
      return
    end
    m.reply "You are editing line #{lineNum} to #{text}"
    rulesMod= Rule.getLatestRule
    rulesLast=rulesMod.last
    rules=rulesLast.rules.split(/\r?\n/)
    rules[lineNum.to_i-1]=text
    newRules=Rule.new
    newRules.rules=rules.join("\r\n")
    newRules.save
  end
  
  def appendLine(m,text)
    if(!checkMaster(m))
      return
    end
    m.reply "You are appending line #{text}"
  rulesMod= Rule.getLatestRule
    rulesLast=rulesMod.last
    newRules=Rule.new
    newRules.rules="#{rulesLast.rules}\r\n#{text}"
    newRules.save
end
  def prependLine(m,text)
    if(!checkMaster(m))
      return
    end
    m.reply "You are prepending line #{text}"
  rulesMod= Rule.getLatestRule
    rulesLast=rulesMod.last
    newRules=Rule.new
    newRules.rules="#{text}\r\n#{rulesLast.rules}"
    newRules.save
end
  def readRules(m)
    rulesMod= Rule.getLatestRule
    rules=rulesMod.last.rules.split(/\r?\n/)
    rules.each { |x| m.user.safe_notice x}
    user=User.getUserFromUser(m.user)
    user.lastas=m.user.nick
    user.lastseen=DateTime.now
    user.sawrules=DateTime.now
    user.save
  end
  
  def listRules(m)
    rulesMod= Rule.getLatestRule
    puts rulesMod.last.rules
    rules=rulesMod.last.rules.split(/\r?\n/)
    rules.each_with_index {|x,i| m.user.safe_notice "#{i+1}. #{x}"}
  end
end