# feature_package_writer.rb

# ============================================================================ #
# Class to manage the information to present different FPE schema versions     #
#                                                                              #
#                                                                              #
# 2016-07-01 Alan Hurdle - Initial Version                                     #
#                                                                              #
# Copyright (c) 2016, Foxtel Management All rights reserved.                   #
# ============================================================================ #

require 'yaml'
require 'erb'
require 'time'

require_relative 'Vpi_constants'
require_relative 'Vpi_2_5'
require_relative 'Vpi_3_0'

class FeaturePackageWriter
  include ERB::Util
  
 public
  # Initialise the class with a media configuration file
  # this defines the base metadata for the offer.
  def initialize(file)
    
    @file   = File.expand_path(file)
    File.open(file, "r") do |f|
      @item = YAML.load_file(f)
    end
    
    # Is there a trailer to configure?
    @trailer = @item.key?("trailer")
    
    # Get the required season episode number from the config
    if @item['content'].key?("episode")
      number = @item['content']['episode']['number']
      season, episode = number.match(/^S(\d+)E(\d+)/i).captures
      @item['content']['episode']['season'] = season
      @item['content']['episode']['episode_number'] = episode
    end

    # Ensure that the price field is always set
    @item['offer']['price'] = "0.00" if !@item['offer'].has_key?('price')

    # Set the base operation modes      
    @media_operation = :nop
    @offer_operation = :nop
    @trailer_operation = :nop
  end
  
  # Quick access to the core metadata that is used to determine the
  # offer and media configuration
  def [](key)
    return @item[key]
  end
  
  # Offer Operation messages
    
  # Set the create offer operation flag signalling a we offer
  # is being sent. A new offer is sent when a new programme 
  # is created and when a media asset is split or shared.
  def newOffer()
    @offer_operation = :create
  end
  
  # The receiving system must update the offer specific metadata 
  # such as the exhibition window or parental guidance.
  # This operation is used typically for a change of exhibition date, 
  # asset replace or offer expiration
  def updateOffer()
    @offer_operation = :update
  end
  
  # The offer is to be expired immediately.
  # The media may still remain if there is no associated media
  # expiration command.
  def expireOffer()
    # Put the offer date in the past
    @item['offer']['window']['start'] = "2016-01-01 00:00:00 +10"
    @item['offer']['window']['end']   = "2016-01-01 00:00:00 +10"
      
    @offer_operation = :expire
    @media_operation = :update
    if @trailer
      @trailer_operation = :update
    end
  end

  # Expire the offer and the media immediately
  # This requires removing the content from the origin.  
  def expireOfferAndMedia()
    self.expireOffer()
    @media_operation = :expire
    if @trailer
      @trailer_operation = :expire
    end
  end  
  
  # Utility method for the step definition processing to adjust the
  # offer window configuration. 
  def setOfferWindow(window)
    @item['offer']['window']['start'] = window[:start]
    @item['offer']['window']['end']   = window[:end]
  end

  # Temporarily hide the offer  
  def hideOffer()
    @item['offer']['activate'] = false
    self.updateOffer()
  end

  # A new asset has been supplied for the offer
  # Typically used on creation of the content and split
  def newProgramme()
    @media_operation = :create
  end
  
  # Update the metadata associated with the programme media
  def updateProgramme()
    @media_operation = :update
  end

  # Replace the media asset in use without taking down the offer 
  def replaceProgramme()
    @media_operation = :replace
  end
  
  # In an asset sharing scenario split the PPV and subscription
  # media away from each-other.
  def splitProgramme()
    @media_operation = :split
  end

  # Trailer Media operations
  
  def newTrailer()
    @trailer = true
    @trailer_operation = :create
  end
  
  def updateTrailer()
    @trailer = true
    @trailer_operation = :update
  end
  
  def replaceTrailer()
    @trailer = true
    @trailer_operation = :replace
  end
  
  # Media asset messages
  
  # Set the asset identifier for programmes and trailers
  def setMediaAsset(media, asset)
    # Set the asset identifiers
    media['asset'] = asset
  end

  # Set the license window for the programme or trailer asset
  def setMediaLicense(media, license)
    # Set the asset license window
    media['license']['start'] = license[:start]
    media['license']['end']   = license[:end]
  end

  def setProgrammeAsset(asset)
    programme = @item['programme']
    setMediaAsset(programme, asset)
  end
  
  def setTrailerAsset(asset)
    @trailer = true 
    trailer = @item['trailer']
    setMediaAsset(trailer, asset)
  end
  
  def setProgrammeLicense(window)
    programme = @item['programme']
    setMediaLicense(programme, window)
  end
  
  def setTrailerLicense(window)
    @trailer = true 
    trailer = @item['trailer']
    setMediaLicense(trailer, window)
  end

  # Include the highest resolution of the offered content 
  def setProgrammeResolution(resolution)
    @item['offer']['resolution'] = resolution
    @item['programme']['resolution'] = resolution
  end

  # Identifiers for the programme asset
  
  # Version refers to the cut of the media and is mainly used
  # to identify different content such as parental rating versions
  def setProgrammeVersion(version)
    @item['programme']['version'] = version    
  end
  
  # Version copy refers to a specific asset instance of a programme
  def setProgrammeVersionCopy(versionCopy)
    @item['programme']['versionCopy'] = versionCopy
  end
  
  # An offer maybe subscription or PPV
  def setOfferType(offer_type)
    # Set the offer type based on the required test
    # This allows programme content definitions to be used for both PPV and subscription
    # offers.
    offer = @item['offer']
    offer['offerType'] = offer_type
      
    # Set the accessTerm value depending on the Subscription/PPV value
    # to ensure the correct DRM model is applied.
    if offer_type == 'Subscription'
      offer['accessTerm'] = 'CA900004'
    else
      offer['accessTerm'] = 'CA900006'
      offer['rental'] = '48'
      offer['timeToStartView'] = 'P7D'
    end    
  end
  
  # Output the offer metadata as one of the FPE schema versions
  def export_xml(version)
  
    # Make sure all of the dates are in the right format
    @item['date'] = Time.now.utc.iso8601
    for section in ['offer', 'programme', 'trailer']
      case section
      when 'offer'
        label = 'window'
      else
        label = 'license'
      end
      if @item.has_key?(section)
        for period in ['start', 'end']
          @item[section][label][period] = @item[section][label][period].utc.iso8601
        end
      end
    end

    case version
    when :fpe2_5      
      template = ERB.new(Vpi2_5.get_xml_template(), nil, '-')
    when :fpe3_0
      template = ERB.new(Vpi3_0.get_xml_template(), nil, '-')
    else
      exit("Feature Package version " + version.to_s + " not supported")
    end
    
    template.result(binding)  
  end
  # End

  # sharedOffer and newOffer have the same functionality 
  alias_method :sharedOffer, :newOffer
    
end