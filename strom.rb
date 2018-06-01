require 'sinatra'
require 'sinatra/config_file'
require 'json'
require 'fileutils'

config_file 'config.yml'

get '/' do
  erb :index, download_files: download_files
end

post '/move' do
  cmd = JSON.parse(request.body.read)
  logger.info "Moving #{cmd}"
  `mv "#{File.join(settings.download_folder, cmd['name'])}" "#{File.join(settings.video_folder, cmd['name'])}"`
  logger.info "Moved #{cmd}"
end

def download_files
  Dir.glob("#{settings.download_folder}/*").map { |f| File.basename f }
end
