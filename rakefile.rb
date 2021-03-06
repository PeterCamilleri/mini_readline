#!/usr/bin/env rake
# coding: utf-8

require 'rake/testtask'
require "bundler/gem_tasks"

#Run the mini_readline unit test suite.
Rake::TestTask.new do |t|
  #List out all the test files.
  t.test_files = FileList['tests/**/*.rb']
  t.verbose = false
end

desc "Fire up an IRB session with the local mini_readline."
task :console do
  system "ruby irbt.rb local"
end

desc "Run a scan for smelly code!"
task :reek do |t|
  `reek --no-color lib > reek.txt`
end

desc "What version of mine_readline is this?"
task :vers do |t|
  puts
  puts "mini_readline version = #{MiniReadline::VERSION}"
end

desc "Alternative test procedure."
task :alt_test do |t, args|
  here  = File.dirname(__FILE__)
  target = "#{here}/tests/*.rb"

  block = "{|file| require file if File.basename(file) =~ /test/}"
  code  = "Dir['#{target}'].each #{block}"

  system "ruby -e\"#{code}\""
end
