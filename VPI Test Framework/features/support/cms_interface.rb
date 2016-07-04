# cms_interface.rb

# ============================================================================ #
# Notional interface class to handle communications and fpe comparison with    #
# Nagra CMS.                                                                   #
#                                                                              #
# 2016-07-01 Alan Hurdle - Inital Version                                      #
#                                                                              #
# Copyright (c) 2016, Foxtel Management All rights reserved.                   #
# ============================================================================ #

class CMS
  def initialize(version)
    @success = false
    @message = ""

    case version
    when :fpe2_5
      @inbox_location = "path/to/2.5/ingest"
      @version   = 2.5
    when :fpe3_0
      @inbox_location = "path/to/3.0/ingest"
      @version   = 3.0
    else
      exit(1)
    end
  end
  
  def deliver(fpe)
    # Send the FPE to the CMS inbox and wait for a response
    # this will also require creating the media files too
    @message = "Deliver not implemented"
  end
  
  def success
    @success
  end
  
  def message
    @message
  end
  
end