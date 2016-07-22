# Author: alan.hurdle@foxtel.com.au
#
# Revisions
# Date  :  

# Feature Definition Template
@new_offer
Feature: Test Suite 1: New offers are created using both VOD production systems: VESPA and BCMS. 
	

@new_offer
Scenario: Create an HD PPV offer (TC1a)
    Given I create a PPV-Libray offer 00000001 for programme 1234567
      And The offer is active in 10 minutes for 2 hours
      And It has new programme media ON123456
      And The programme is valid for 100 days
     Then I export the offer as FPE3.0
      And I write it in new_offer_tests as tc1a

@new_offer
Scenario: Create an split HD subscription offer for programme 1234567 (TC1b)
    Given I create a Subscription offer 00000002 for programme 1234567
      And The offer is active in 10 minutes for 2 hours
      And It has new programme media ON123457
      And The programme is valid for 100 days
     Then I export the offer as FPE3.0
      And I write it in new_offer_tests as tc1b

@new_offer
Scenario: Create an HD Subscription offer which will be shared (TC1c)
    Given I create a Subscription offer 00000003 for programme 1234568
      And The offer is active now for 2 hours
      And It has new programme media ON123458
      And The programme is valid for 100 days
     Then I export the offer as FPE3.0
      And I write it in new_offer_tests as tc1c

@new_offer
Scenario: Create a shared HD PPV-Library offer (TC1d)
    Given I share a PPV-Library offer 00000004 for programme 1234568
      And The offer is active now for 2 hours
      And It has new programme media ON123458
      And The programme is valid for 100 days
     Then I export the offer as FPE3.0
      And I write it in new_offer_tests as tc1d

# TODO Figure out how to output CR62 FPE
@new_offer
Scenario: Create a CR62 HD PPV offer (TC1g)
    Given I create a PPV-New offer 00000005 for programme 1234569
      And The offer is active now for 2 hours
      And It has new programme media ON123459
      And The programme is valid for 100 days
     Then I export the offer as CR62
      And I write it in new_offer_tests as tc1g

@new_offer
Scenario: Create a BCMS SD PPV offer (TC1h)
    Given I create a PPV-New offer 00000006 for programme 1234569
      And The offer is active now for 2 hours
      And It has new programme media ON123460
      And The programme is valid for 100 days
     Then I export the offer as FPE2.5
      And I write it in new_offer_tests as tc1h

@new_offer
Scenario: Create a BCMS SD Subscription offer (TC1i)
    Given I create a Subscription offer 00000007 for programme 1234569
      And The offer is active now for 2 hours
      And It has new programme media ON123461
      And The programme is valid for 100 days
     Then I export the offer as FPE2.5
      And I write it in new_offer_tests as tc1i

