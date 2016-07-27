# offer_definition_steps.rb

# ============================================================================ #
# Step definition for creating and managing offer test cases                   #
#                                                                              #
#                                                                              #
# 2016-07-01 Alan Hurdle - Initial Version                                     #
#                                                                              #
# Copyright (c) 2016, Foxtel Management All rights reserved.                   #
# ============================================================================ #

# Create an FPE base document from the feature scenario
Given(/^I (\w+) a (Subscription[-A-Za-z0-9]*|PPV[-A-Za-z0-9]*) offer (\d+) for programme (\d+)$/) do |offer_operation, offer_type, offer_number, programme|
  filename = programme_config_filename(programme)
  fpe = FeaturePackageWriter.new(filename)
  @fpe = fpe
  select_offer_operation(offer_operation, @fpe)

  # Set the asset information based from the test specification
  fpe['offer']['id'] = offer_number
  fpe['content']['programme'] = programme
  fpe.setOfferType(offer_type)
end

# Generate the correct time window from the scenario - both offer and media
Given(/^The (\w+) is (?:active|valid) in (\d+) (\w+) for (\d+) (\w+)$/) do |type, start_offset, start_units, end_duration, end_units|
  now = Time.now.utc
  window = {
    :start => now + (start_offset.to_f * get_time_units_multiplier(start_units)),
    :end   => now + (end_duration.to_f * get_time_units_multiplier(end_units))
  }
  
  set_fpe_time_window(@fpe, type, window)
end

# Generate a time window from now for a specified duration
Given(/^The (\w+) is (?:active|valid)(?: now){0,1} for (\d+) (\w+)$/) do |type, end_duration, end_units|
  now = Time.now.utc
  window = {
    :start => now,
    :end   => now + (end_duration.to_f * get_time_units_multiplier(end_units))
  }
  
  set_fpe_time_window(@fpe, type, window)
end

# Get the media operation and media number of the fpe
Given(/^It (?:has |had ){0,1}(\w+) programme media (\w+)$/) do |programme_operation, asset|
  resolution = "SD"
  # Set the asset information based from the test specification
  @fpe.setProgrammeAsset(asset)
  @fpe.setProgrammeResolution(resolution)
  select_programme_operation(programme_operation, @fpe)
end

# Get the media operation, number and content resolution of the fpe
Given(/^It (?:has |had ){0,1}(\w+) programme media (\w+) in (HD|SD)$/) do |programme_operation, asset, resolution|
  # Set the asset information based from the test specification
  # Set the asset information based from the test specification
  @fpe.setProgrammeAsset(asset)
  @fpe.setProgrammeResolution(resolution)
  select_programme_operation(programme_operation, @fpe)
end

# Placeholder for dealing with sending content to Nagra 
Given(/^I (?:send|sent) the offer as (FPE\d.\d) to CMS$/) do |version|
  version = get_version_symbol(version)
  @fpe.export_xml(version)  
end

# Export the fpe information as a specific schema version 
Then(/^I export the offer as (FPE\d.\d)$/) do |version|
  version = get_version_symbol(version)
  @xml = @fpe.export_xml(version)  
end

# Export the fpe information as a specific schema version 
Then(/^I export the offer as (CR62)$/) do |version|
  version = get_version_symbol('FPE2.5')
  # TODO Set the RedBee fields accordingly here
  
  @xml = @fpe.export_xml(version)  
end

# Save the exported fpe to the file system
Then(/^I write it in (\S*) as (\S*)$/) do |location, name|

  path = File.join(File.dirname(__FILE__), '..', '..', location)
  Dir.mkdir path if !Dir.exist?(path)
  filename = name + '.xml'
  f = File.open(File.join(path, filename), 'w')
  f.write(@xml)
  
  # TODO Have media and image files at hand so that they can be renamed and sent with the FPE
  #
  #
  
end

# Narga CMS will have an SD subscription VOD item for programmeId 1234567 with mediaId ON23456
Then(/^Narga CMS will have an (SD|HD) (Subscription[-A-Za-z0-9]*|PPV[-A-Za-z0-9]*) VOD item for programme (\d+) with media (\w+)$/) do |resolution, type, programmeId, assetId|
  pending # Write code here that turns the phrase above into concrete actions
end