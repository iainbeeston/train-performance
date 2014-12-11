namespace :import do
  desc "Imports data from the RTPPM api"
  task rtppm: :environment do
    RtppmSnapshot.import
  end
end
