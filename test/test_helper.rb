$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dotenv'
Dotenv.load
require 'destiny'
require 'hurley/test'
require 'minitest/autorun'
