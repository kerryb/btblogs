Rake::Task[:default].clear_prerequisites
task :default => [:spec, :features]
