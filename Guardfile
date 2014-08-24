# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{views/.+\.erb})
  watch(%r{css/.+\.scss})
end

guard :rspec, cmd: 'rspec' do
  watch(%r{^spec/.+spec\.rb})
  watch(%r{views/.+\.erb})
  watch(%r{css/.*})
  watch(%r{javascripts/.*})
end
