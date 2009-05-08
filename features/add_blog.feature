Story: Add a new blog to the list

  Background:
    When I go to the homepage
    And I follow "Add blog"

  Scenario: Form submission cancelled
    When I press "Cancel"
    Then I should be on the homepage

  Scenario: Missing mandatory fields
    When I press "Save"
    Then I should see "Owner name can't be blank"
    And I should see "Owner email can't be blank"
    And I should see "Html uri can't be blank"
    And I should see "Feed uri can't be blank"

  Scenario: Non-BT e-mail address
    When I fill in "Your name" with "Fred Bloggs"
    And I fill in "Your e-mail address" with "fred.bloggs@not-bt.com"
    And I fill in "Blog URL" with "http://blog.fredbloggs.com"
    And I fill in "Feed URL" with "http://blog.fredbloggs.com/feed"
    And I press "Save"
    Then I should see "Owner email must be @bt.com"

  Scenario: Successfully adding a blog
    When I fill in "Your name" with "Fred Bloggs"
    And I fill in "Your e-mail address" with "fred.bloggs@bt.com"
    And I fill in "Blog URL" with "http://blog.fredbloggs.com"
    And I fill in "Feed URL" with "http://blog.fredbloggs.com/feed"
    And I press "Save"
    Then I should be on the homepage
    And I should see "You should receive an e-mail shortly"
    And I should not see "Fred Blogs"
    And "fred.bloggs@bt.com" should receive 1 email
    When "fred.bloggs@bt.com" opens the email
    Then I should see "BTBlo.gs Confirmation" in the subject
    Then I should see "Thank you for registering" in the email
    When I follow "/blogs" in the email
    Then I should be on the homepage
    And I should see "Thank you, your blog has now been confirmed."
    And I should see "Fred Bloggs"

  Scenario: Attempting confirmation with the wrong code
