Story: Add a new blog to the list

  Background:
    When I go to the homepage
    And I follow "Add blog"

  Scenario: Successfully adding a blog
    When I fill in "Your name" with "Fred Bloggs"
    And I fill in "Your e-mail address" with "fred.bloggs@bt.com"
    And I fill in "Blog URL" with "http://blog.fredbloggs.com"
    And I press "Save"
    Then I should see "You should receive an e-mail shortly"
