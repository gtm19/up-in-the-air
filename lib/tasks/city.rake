namespace :city do
  desc "Enriching cities with photos and proper names (TODO)"
  task update_all: :environment do
    AddPhotosJob.perform_later(true)
  end

  task update_blanks: :environment do
    AddPhotosJob.perform_later(false)
  end
end
