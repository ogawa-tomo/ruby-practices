# frozen_string_literal: true

require 'etc'

class FileData
  attr_reader :name

  def initialize(name)
    @name = name
    @stat = File.stat(name)
  end

  def ftype
    @stat.ftype == 'file' ? '-' : @stat.ftype[0]
  end

  def mode
    result = []
    mode_num = format('%o', @stat.mode)[-3..]
    mode_num.each_char do |char|
      num = char.to_i
      result << ((num & 0b100).positive? ? 'r' : '-')
      result << ((num & 0b010).positive? ? 'w' : '-')
      result << ((num & 0b001).positive? ? 'x' : '-')
    end
    result.join
  end

  def nlink
    @stat.nlink
  end

  def owner
    Etc.getpwuid(@stat.uid).name
  end

  def group
    Etc.getgrgid(@stat.gid).name
  end

  def size
    @stat.size
  end

  def mtime
    @stat.mtime.strftime('%b %e %H:%M')
  end

  def blocks
    @stat.blocks / 2
  end
end