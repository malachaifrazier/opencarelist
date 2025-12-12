require "rails_helper"

RSpec.describe OpenCareList::Import::MasterCsvImporter do
  let(:csv_path) { Rails.root.join("spec/fixtures/opencarelist_sample.csv") }

  it "imports doctors, locations, and listings" do
    importer = described_class.new(csv_path: csv_path)
    expect { importer.call }.to change { Doctor.count }.by(1)
                            .and change { Location.count }.by(1)
                            .and change { Listing.count }.by(1)
  end
end
