Story: Add a new blog to the list

  Background:
    When I go to the homepage
    And I follow "Add blog"

  Scenario: Successfully adding a blog
    When I fill in "Your name" with "Fred Bloggs"
    And I fill in "Your e-mail address" with "fred.bloggs@bt.com"
    And I fill in "Blog URL" with "http://blog.fredbloggs.com"
    And I fill in "Feed URL" with "http://blog.fredbloggs.com/feed"
    And I press "Save"
    Then I should see "You should receive an e-mail shortly"

  Scenario: Form submission cancelled
    When I press "Cancel"
    Then I should be on the homepage

  Scenario: Missing mandatory fields
    When I press "Save"
    Then I should see "Owner name can't be blank"
    Then I should see "Owner email can't be blank"
    Then I should see "Html uri can't be blank"
    Then I should see "Feed uri can't be blank"

  Scenario: Non-BT e-mail address

  Scenario: Blog addition not confirmed
