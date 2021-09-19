#!/usr/bin/env ruby
require "slack-ruby-client"
require "./deepl-api"

class App
    Slack.configure do |config|
        config.token = ENV["SLACK_API_TOKEN"]
    end
    
    client = Slack::RealTime::Client.new
    
    client.on :hello do
        puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
    end

    client.on :message do |data|
        translated = DeepL.request(data.text)
        client.message(channel: data.channel, text: translated)
    end
    
    client.start!
end