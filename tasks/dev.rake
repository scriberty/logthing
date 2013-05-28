namespace :dev do
  desc "Symlink logthing into the ES plugins directory"
  task :link do
    cwd = Dir.pwd.strip
    es  = `brew --prefix elasticsearch`.strip
    sh "ln -fs #{cwd} #{es}/plugins/logthing"
  end
end
