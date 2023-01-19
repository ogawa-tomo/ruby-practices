#!/usr/bin/env ruby

require 'date'
require 'optparse'

def print_day(day)
  if day < 10
    print " #{day} "
  else
    print "#{day} "
  end
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

month = if params[:month]
          params[:month]
        else
          Date.today.month
        end
year = if params[:year]
         params[:year]
       else
         Date.today.year
       end

puts "     #{month}月 #{year}"
puts '日 月 火 水 木 金 土'

month_last_day = Date.new(year, month, -1).day
(1..month_last_day).each do |day|
  date = Date.new(year, month, day)
  print_space_before_first_day(date) if date.day == 1
  print_day(day)
  puts '' if date.saturday?
end


