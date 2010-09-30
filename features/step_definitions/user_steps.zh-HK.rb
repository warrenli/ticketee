# encoding: utf-8

假設 /^有一位帳戶電郵地址是"([^"]*)"密碼是"([^"]*)"$/ do |email, password|
  @user = User.create!(:email => email, :password => password, :password_confirmation => password)
end

假設 /^"([^"]*)"已確認帳戶$/ do |email|
  User.find_by_email(email).confirm!
end

假設 /^已成功登入系統$/ do
  steps %Q(
    Given I am on the homepage
    When I follow "登入"
    And I fill in "電郵地址" with "#{@user.email}"
    And I fill in "帳戶密碼" with "#{@user.password}"
    And I press "登入"
    Then I should see "登錄成功。"
  )
end

假設 /^"([^"]*)"給這個專案建立以下工作單:$/ do |email, table|
  table.hashes.each do |ticket|
    @project.tickets.create!(ticket.merge!(:user => User.find_by_email!(email)))
  end
end
