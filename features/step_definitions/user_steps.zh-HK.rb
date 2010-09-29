# encoding: utf-8

假設 /^有一位帳戶電郵地址是"([^"]*)"密碼是"([^"]*)"$/ do |email, password|
  User.create!(:email => email, :password => password, :password_confirmation => password)
end
