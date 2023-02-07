#!/usr/bin/env ruby

require 'date'
require 'optparse'

def print_day(day)
  print day.to_s.rjust(2) + ' '
end

def print_space_before_first_day(date)
  print ' ' * 3 * date.wday
end

opt = OptionParser.new
params = {}
opt.on('-m VAL') do |v| 
  m = v.to_i
  raise '月には1から12までの数字を指定してください' unless (1..12).cover?(m) 
  params[:month] = m
end
opt.on('-y VAL') do |v|
  y = v.to_i
  raise '年には1970から2100までの数字を指定してください' unless (1970..2100).cover?(y)
  params[:year] = y
end
opt.parse!(ARGV, into: params)

month = params[:month] || Date.today.month
year = params[:year] || Date.today.year

puts "     #{month}月 #{year}"
puts '日 月 火 水 木 金 土'

print_space_before_first_day(Date.new(year, month, 1))
(Date.new(year, month, 1)..Date.new(year, month, -1)).each do |date|
  print_day(date.day)
  puts '' if date.saturday?
end


