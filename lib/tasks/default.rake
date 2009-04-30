ENV["RAILS_ENV"] ||= "test"
Rake::Task[:default].clear_prerequisites
task :default => [:spec, :features]
