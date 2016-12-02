#!/usr/bin/env ruby 
#
#

require "benchmark"
require 'set'
require 'rb_lovely'
require 'colored2'

ITER = 100000
CAP = 1000


def add_uncapped(set, v)
  set << v
end

def add_capped_delete_first(set, v, cap)
  if set.length >= cap
    set.delete(set.first)
  end
  set << v
end

def add_capped_delete_last(set, v, cap)
  if set.length >= cap
    set.delete(set.respond_to?(:last) ? set.last : set.to_a.last)
  end
  set << v
end


def time_set(set)
Benchmark.bm(30) do |x|
  x.report("WITHOUT the cap")        { set.clear; (1..ITER).each { |i| add_uncapped(set, i) } }
  x.report("CAP at 1000, del first") { set.clear; (1..ITER).each { |i| add_capped_delete_first(set, i, 1000) } }
  x.report("CAP at 1000, del last")  { set.clear; (1..ITER).each { |i| add_capped_delete_last(set, i, 1000) } }
end
end

puts
puts "RbLovely::SortedSet".bold.red
set = RbLovely::SortedSet.new
time_set(set)

puts
puts "SortedSet".bold.red
set = SortedSet.new
time_set(set)

