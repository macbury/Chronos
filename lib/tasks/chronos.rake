require 'jammit'
namespace :chronos do
  
  task :clear_files do
    Dir[File.join(Rails.root, 'tmp', 'uploads', '*.*')].each do |file|
      created_at = File.mtime(file)
      if created_at <= 3.hours.ago
        File.delete(file)
      end
    end
  end
  
  task :jammit => :environment do
    Jammit.package!
  end
  
  task :notifications => :environment do
    Link.order("created_at DESC").where("created_at > ?", 4.weeks.ago).find_in_batches(:batch_size => 500 ) { |links| links.each(&:check_notification) }
  end
end
