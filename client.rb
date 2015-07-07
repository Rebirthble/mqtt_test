#require 'rubygems'
$:.unshift(File.join(File.dirname(__FILE__), '.', 'vendor/ncmb-ruby-client/lib'))
$:.unshift(File.dirname(__FILE__))
require 'ncmb'
require 'mqtt'
require 'json'
require 'yaml'

include NCMB
if File.exist?('./setting.yml')
    yaml = YAML.load_file(File.join(File.dirname(__FILE__), '.', 'setting.yml'))
    NCMB.initialize application_key: yaml['application_key'],  client_key: yaml['client_key']
else 
    NCMB.initialize application_key: "",  client_key: ""
end

# Subscribe example
MQTT::Client.connect('mqtt://test.account:test.account@m01.mqtt.cloud.nifty.com:16030') do |c|
  # If you pass a block to the get method, then it will loop
  c.get('mbaas/test') do |topic,message|
    @@client.post '/2013-09-01/classes/message', JSON.parse('{"message":' + message + '}')    
    puts "#{topic}: #{message}"
  end
end
