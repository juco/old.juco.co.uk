require 'rake'
require 'coffee-script'
require 'uglifier'

desc 'Compile the assets'
task :assets do
  compiled = ''
  Dir.glob('javascripts/*.coffee').each do |file|
    compiled += CoffeeScript.compile(File.open file)
  end
  File.open('tmp/app.js', 'w') { |f| f.write compiled }
  File.open('dist/app.js', 'w') { |f| f.write(Uglifier.compile(File.read('tmp/app.js'))) }
end
