# features/support/fpe_interface.rb

# ============================================================================ #
# Utility methods to  support the offer definition steps                       #
#                                                                              #
#                                                                              #
# 2016-07-01 Alan Hurdle - Inital Version                                      #
#                                                                              #
# Copyright (c) 2016, Foxtel Management All rights reserved.                   #
# ============================================================================ #

def get_version_symbol(version_str)
  version_str.downcase.tr('.','_').to_sym
end

def programme_config_filename(programme)
  File.join(File.dirname(__FILE__), programme.to_s + ".yml")
end

def select_offer_operation(operation, fpe)
  case operation.downcase 
  when 'create','created','new'
    fpe.newOffer
  when 'update','existing'
    fpe.updateOffer
  when 'expire'
    fpe.expireOffer
  else
    exit("Unsupported operation " + operation + " for offers")
  end
end

def select_programme_operation(operation, fpe)
  
  case operation.downcase 
  when 'create','created','new'
    fpe.newProgramme
  when 'update','existing'
    fpe.updateProgramme
  when 'split','separate'
    fpe.splitProgramme
  when 'expire'
    fpe.expireOfferAndMedia
  else
    exit("Unsupported operation " + operation + " for offers")
  end
end

def get_time_units_multiplier(units_str)
  
  case units_str.downcase
  when 'seconds'
    multiplier = 1
  when 'minutes'
    multiplier = 60
  when 'hours'
    multiplier = 3600
  when 'days'
    multiplier = 86400
  when 'weeks'
    multiplier = 86400 * 7
  when 'months'
    multiplier = 86400 * (365/12)
  when 'years'
    multiplier = 86400 * 365
  else
    exit("Unrecognised time unit " + units_str)
  end
  multiplier
end

def   set_fpe_time_window(fpe, type, window)
  case type
  when 'programme'
    fpe.setProgrammeLicense(window)
  when 'trailer'
    fpe.setTrailerLicense(window)
  when 'offer'
    fpe.setOfferWindow(window)
  else
    exit("Unrecognised window type " + type)
  end
end

def send_fpe(fpe, version)
   
  # Send the FPE document to CMS
  cms = CMS.new(version)
  cms.deliver(fpe.export_xml(version))
  
  return [cms.success, cms.message]
end