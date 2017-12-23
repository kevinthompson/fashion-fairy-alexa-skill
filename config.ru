$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'dotenv/load'
require 'fashion_fairy/alexa/server'
run FashionFairy::Alexa::Server
