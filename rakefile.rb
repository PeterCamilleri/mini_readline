#!/usr/bin/env rake
# coding: utf-8

require 'rake/testtask'
require 'rdoc/task'
require "bundler/gem_tasks"

#Generate internal documentation with rdoc.
RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"

  #List out all the files to be documented.
  rdoc.rdoc_files.include("lib/**/*.rb", "license.txt", "README.md")

  #Make all access levels visible.
  rdoc.options << '--visibility' << 'private'
  #rdoc.options << '--verbose'
  #rdoc.options << '--coverage-report'

  #Set a title.
  rdoc.options << '--title' << 'Mini Readline Gem'
end

#Run the mini_readline unit test suite.
Rake::TestTask.new do |t|
  #List out all the test files.
  t.test_files = FileList['tests/**/*.rb']
  t.verbose = false
end

desc "Fire up an IRB session with mini_readline."
task :console do
  require 'irb'
  require 'irb/completion'
  $force_alias_read_line_module = true
  require './lib/mini_readline'
  puts "Starting an IRB console with mini_readline."
  ARGV.clear
  IRB.start
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