require 'rake'
require 'coffee-script'
require 'uglifier'

desc 'Compile the assets'
task :assets do
  compiled = ''

  # Add compiled coffee
  Dir.glob('javascripts/*.coffee').each do |file|
    compiled += CoffeeScript.compile(File.open file)
  end

  # Add JS
  Dir.glob('javascripts/*.js').each do |file|
    File.open file, 'r' do |f|
      while content = f.gets
        compiled += content
      end
    end
  end

  File.open('tmp/app.js', 'w') { |f| f.write compiled }
  File.open('dist/app.js', 'w') do |f|
    f.write(Uglifier.compile(File.read('tmp/app.js')))
  end
end
