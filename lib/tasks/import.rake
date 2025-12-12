namespace :import do
  desc "Import the master OpenCareList CSV"
  task opencarelist: :environment do
    csv = ENV["CSV"]

    unless csv
      puts "Usage: rake import:opencarelist CSV=path/to/opencarelist_clean.csv"
      exit 1
    end

    OpenCareList::Import::MasterCsvImporter.new(csv_path: csv).call
  end
end
# bin/rails import:opencarelist CSV=data/opencarelist/opencarelist_clean.csv
