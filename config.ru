$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
$stdout.sync = true
require 'dotenv/load'
require 'fashion_fairy/alexa/server'
run FashionFairy::Alexa::Server
