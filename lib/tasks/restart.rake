task :restart do
  FileUtils.touch File.dirname(__FILE__) + '/../../tmp/restart.txt'
end
