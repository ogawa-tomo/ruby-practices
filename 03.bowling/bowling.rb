#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames.each_with_index do |frame, i|
  if i >= 9 # 10フレーム目以降は普通に足すだけ
    point += frame.sum
  elsif frame[0] == 10 # strike
    if frames[i + 1][0] == 10 # 次の一投もストライク
      point += 20 + frames[i + 2][0]
    else
      point += 10 + frames[i + 1].sum
    end
  elsif frame.sum == 10 # spare
    point += 10 + frames[i + 1][0]
  else
    point += frame.sum
  end
end
puts point
