class Kick
  include Cinch::Plugin

  match "kicks the bot", react_on: :action, use_prefix: false
  def execute(m)
    m.action_reply "looks at #{m.user.nick} blankly. \"Please stop that.\""
  end
end