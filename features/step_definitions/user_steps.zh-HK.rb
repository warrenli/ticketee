# encoding: utf-8

假設 /^有一位帳戶電郵地址是"([^"]*)"密碼是"([^"]*)"$/ do |email, password|
  User.create!(:email => email, :password => password, :password_confirmation => password)
end

假設 /^"([^"]*)"已確認帳戶$/ do |email|
  User.find_by_email(email).confirm!
end
