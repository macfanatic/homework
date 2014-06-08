require 'bundler'
Bundler.require :default

Dir['./services/**/*.rb'].each { |f| require f }

unless ARGV.size == 1
  puts "Usage: ruby bin/convert.rb <input_file>"
  exit
end

input = ARGV.first
puts ConvertInputFileToJSON.call input
