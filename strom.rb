require 'sinatra'
require 'sinatra/config_file'
require 'json'
require 'fileutils'

config_file 'config.yml'

puts "DOWNLOAD_FOLDER: #{settings.download_folder}"
puts "VIDEO_FOLDER: #{settings.video_folder}"

get '/' do
  erb :index, download_files: download_files
end

post '/move' do
  cmd = JSON.parse(request.body.read)
  puts cmd
  FileUtils.mv(File.join(settings.download_folder, cmd['name']),
               File.join(settings.video_folder, cmd['name']))
end

def download_files
  Dir.glob("#{settings.download_folder}/*").map { |f| File.basename f }
end
