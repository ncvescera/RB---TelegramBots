#!/usr/bin/ruby

require 'daemons'
require 'rubygems'

current_dir = Dir.pwd

#comando per gestire il demone
cmd = ARGV[0]

#oggetto che contiene gli argomenti da passare allo script demone
options = {
    :ARGV       => ["#{cmd}", '-f', '--', "#{current_dir}/"],
  }

#demonizzazione dello scirpt
Daemons.run("blallo.rb", options)
