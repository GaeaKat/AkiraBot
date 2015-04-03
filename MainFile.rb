require 'rubygems'
require 'bundler/setup'

require 'cinch'
require 'logger'
require 'yaml'
require 'will_paginate'
require 'will_paginate/active_record'  # or data_mapper/sequel

$botconfiguration = YAML::load(IO.read('config/bot.yml'))
Dir[File.dirname(__FILE__) + '/Plugins/*'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/libs/*'].each {|file| require file }
require './App'
$bot = Cinch::Bot.new do
  configure do |c|
    c.server = $botconfiguration['server']['ip']
    c.channels = $botconfiguration['server']['channels']
    c.nick=$botconfiguration['server']['name']
    c.realname=$botconfiguration['server']['realname']
    c.sasl.username=$botconfiguration['server']['username']
    c.sasl.password=$botconfiguration['server']['password']
    c.plugins.plugins = [Hello,Kick,Who,Master,Rules,Quit,WatchUser,Games]
    c.modes=["B"]
  end
end

$bot.start
