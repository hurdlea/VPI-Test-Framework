# Author: alan.hurdle@foxtel.com.au
#
# Revisions
# Date  :  

@trailer
Feature: Test Suite 2: Trailers are included as part of offers and as separate entities  

@trailer
Scenario: Create an offer that will take a trailer 
    Given I create a Subscription offer 00000008 for programme 1234570
      And The offer is active now for 2 hours
      And It has new programme media ON123462
      And The programme is valid for 100 days
     Then I export the offer as FPE3.0
      And I write it in trailer_tests as tc2a
      
@trailer
Scenario: Update a previous offer with a trailer
    Given I update Subscription offer 00000008 for programme 1234570
      And The offer is active now for 2 hours
      And It has programme media ON123462
      And The programme is valid for 100 days
      And It has new trailer media OT123456
      And The trailer is valid for 100 days
     Then I export the offer as FPE3.0
      And I write it in trailer_tests as tc2b
      



