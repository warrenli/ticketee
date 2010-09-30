Given /^there is a user with the email address "([^\"]*)" and password "([^\"]*)"$/ do |email, password|
  @user = User.create!(:email => email, :password => password, :password_confirmation => password)
end

Given /^"([^\"]*)" has confirmed their account$/ do |email|
  User.find_by_email(email).confirm!
end

Given /^I am signed in as them$/ do
  steps %Q(
    Given I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "#{@user.email}"
    And I fill in "Password" with "#{@user.password}"
    And I press "Sign in"
    Then I should see "Signed in successfully"
  )
end

Given /^"([^"]*)" has created a ticket for this project:$/ do |email, table|
  table.hashes.each do |ticket|
    @project.tickets.create!(ticket.merge!(:user => User.find_by_email!(email)))
  end
end
