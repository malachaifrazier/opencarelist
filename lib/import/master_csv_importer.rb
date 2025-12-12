# lib/opencarelist/import/master_csv_importer.rb
# frozen_string_literal: true

require "csv"

module OpenCareList
  module Import
    class MasterCsvImporter
      def initialize(csv_path:)
        @csv_path = csv_path
      end

      def call
        puts "Starting OpenCareList import..."
        raise "CSV not found: #{@csv_path}" unless File.exist?(@csv_path)

        CSV.foreach(@csv_path, headers: true) do |row|
          import_row(row.to_h)
        end

        puts "Import complete!"
      end

      private

      def import_row(raw)
        doctor = find_or_create_doctor(raw)
        location = find_or_create_location(raw)
        create_or_update_listing(raw, doctor, location)
      end

      def find_or_create_doctor(row)
        name = row["full_name"]&.strip
        credentials = row["credentials"]

        raise "Missing doctor name" if name.blank?

        Doctor.where(full_name: name)
              .first_or_create!(credentials: credentials)
      end

      def find_or_create_location(row)
        Location.where(
          city:       row["city"],
          state_full: row["state_full"],
          state_code: row["state_code"],
          province:   row["province"],
          country:    row["country"]
        ).first_or_create!
      end

      def create_or_update_listing(row, doctor, location)
        Listing.where(
          doctor_id: doctor.id,
          location_id: location.id,
          website_url: row["website_url"]
        ).first_or_create!(
          submitted_by: row["submitted_by"],
          comments:     row["comments"],
          source_region: row["source_region"]
        )
      end
    end
  end
end
