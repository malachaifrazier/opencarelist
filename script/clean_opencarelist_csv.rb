#!/usr/bin/env ruby
# frozen_string_literal: true

require "csv"

INPUT_FILE  = "../data/Gynecologists_with_links_MASTER.csv"
OUTPUT_FILE = "../data/opencarelist_clean.csv"

# US state map
US_STATES = {
  "alabama"=>"AL", "alaska"=>"AK", "arizona"=>"AZ", "arkansas"=>"AR", "california"=>"CA",
  "colorado"=>"CO", "connecticut"=>"CT", "delaware"=>"DE", "florida"=>"FL", "georgia"=>"GA",
  "hawaii"=>"HI", "idaho"=>"ID", "illinois"=>"IL", "indiana"=>"IN", "iowa"=>"IA", "kansas"=>"KS",
  "kentucky"=>"KY", "louisiana"=>"LA", "maine"=>"ME", "maryland"=>"MD", "massachusetts"=>"MA",
  "michigan"=>"MI", "minnesota"=>"MN", "mississippi"=>"MS", "missouri"=>"MO", "montana"=>"MT",
  "nebraska"=>"NE", "nevada"=>"NV", "new hampshire"=>"NH", "new jersey"=>"NJ", "new mexico"=>"NM",
  "new york"=>"NY", "north carolina"=>"NC", "north dakota"=>"ND", "ohio"=>"OH", "oklahoma"=>"OK",
  "oregon"=>"OR", "pennsylvania"=>"PA", "rhode island"=>"RI", "south carolina"=>"SC",
  "south dakota"=>"SD", "tennessee"=>"TN", "texas"=>"TX", "utah"=>"UT", "vermont"=>"VT",
  "virginia"=>"VA", "washington"=>"WA", "west virginia"=>"WV", "wisconsin"=>"WI", "wyoming"=>"WY"
}

def normalize_name(name)
  return [ nil, nil ] if name.nil? || name.strip.empty?

  n = name.dup
  creds = []

  [ "MD", "DO", "CNM", "NP", "OBGYN" ].each do |c|
    if n =~ /\b#{c}\b/i
      creds << c
      n.gsub!(/\b#{c}\b/i, "")
    end
  end

  n.gsub!(/Dr\.?\s*/i, "")
  n.gsub!(/,/, "")
  n = n.strip.split.map(&:capitalize).join(" ")

  [ n, creds.any? ? creds.join(",") : nil ]
end

def normalize_city(city)
  return nil if city.nil? || city.strip.empty?
  c = city.strip
  c.gsub!(/\bSt\.\b/, "Saint")
  c.split.map(&:capitalize).join(" ")
end

def normalize_country(c)
  return nil if c.nil? || c.strip.empty?
  c = c.strip.downcase
  {
    "united states" => "US",
    "usa"           => "US",
    "us"            => "US",
    "canada"        => "CA",
    "australia"     => "AU",
    "europe"        => "EU",
    "africa"        => "AF"
  }[c] || c.upcase
end

def normalize_state(st)
  return [ nil, nil ] if st.nil? || st.strip.empty?
  s = st.strip.downcase
  code = US_STATES[s]
  [ st.strip.split.map(&:capitalize).join(" "), code ]
end

# Load file manually
raw_rows = File.readlines(INPUT_FILE, chomp: true)

# Skip first row ("Table 1")
raw_rows.shift

parsed = CSV.parse(raw_rows.join("\n"), headers: true)

# Identify duplicate column groups
submitted_cols = parsed.headers.select { |h| h&.downcase&.include?("submitted") }
comment_cols   = parsed.headers.select { |h| h&.downcase&.include?("comment") }

CSV.open(OUTPUT_FILE, "w") do |out|
  out << [
    "full_name",
    "credentials",
    "city",
    "state_full",
    "state_code",
    "province",
    "country",
    "website_url",
    "submitted_by",
    "comments",
    "source_region"
  ]

  parsed.each do |row|
    # Merge duplicate columns
    submitted_by = submitted_cols.map { |c| row[c] }.compact.first
    comments     = comment_cols.map   { |c| row[c] }.compact.first

    # Name
    full_name, creds = normalize_name(row["First and Last Name"])

    # Website
    website = row["Hyperlink"]
    website = nil unless website&.start_with?("http")

    # City
    city = normalize_city(row["City"])

    # State
    state_full, state_code = normalize_state(row["State"])

    # Province
    province = row["Province"]

    # Country
    country = normalize_country(row["Country"])

    # Source region from Sheet column
    region = row["Sheet"]

    out << [
      full_name,
      creds,
      city,
      state_full,
      state_code,
      province,
      country,
      website,
      submitted_by,
      comments,
      region
    ]
  end
end

puts "Done! Created #{OUTPUT_FILE}"
