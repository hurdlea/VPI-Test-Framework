Feature: Content offers will be migrated to the new Nagra CMS content model when updated by the FPE3.0 interface

		# This is fallback solution for when we can't talk to Nagra CMS to get the media state
		# If will generate the FPE and put it in a directory 
    Scenario: An SD FPE2.5 offer
        Given I created a Subscription offer 00000001 for programme 1234567
          And The offer is active in 10 minutes for 2 hours
          And It has new programme media ON123456
          And The programme is valid in 10 minutes for 100 days
         Then I export the offer as FPE3.0
          And I write it as Base Offer
        
		# This is potentially the better option provided we can get access to the CMS
		# to verify if the ingested offer content matches the intent of the FPE sequence. 
#    Scenario: An existing SD FPE2.5 offer is updated to HD
#        Given I created a Subscription offer 00000001 for programme 1234567
#          And The offer is active in 10 minutes for 2 hours
#          And It had new programme media ON123456
#          And The programme is valid in 10 minutes for 100 days
#          And I sent the offer as FPE2.5 to CMS
#         When I create a Subscription offer 00000001 for programme 1234567
#          And The offer is active now for 10 days
#          And It has new programme media ON23456
#          And The programme is vaild now for 100 days
#         Then Narga CMS will have an SD Subscription VOD item for programme 1234567 with media ON23456
#          And Narga CMS will have an HD Subscription VOD item for programme 1234567 with media ON23456
        
#    Scenario: A FPE3.0 offer is split
#        Given I created a Subscription offer 00000001 for programme 1234567
#          And The offer is active in 10 minutes for 2 hours
#          And It had new programme media ON123456 in HD
#          And The programme is valid now for 100 days
#          And I sent the offer as FPE3.0 to CMS
#         When I create a PPV-Library offer 0000002 for programme 1234567
#          And It has split programme media ON23456 in HD
#          And I send the offer as FPE3.0 to CMS
#         Then Narga CMS will have an SD Subscription VOD item for programme 1234567 with media ON12345
#          And Narga CMS will have an HD Subscription VOD item for programme 1234567 with media ON12345
#          And Narga CMS will have an SD PPV-Library VOD item for programme 1234567 with media ON12345
#          And Narga CMS will have an HD PPV-Library VOD item for programme 1234567 with media ON12345
          