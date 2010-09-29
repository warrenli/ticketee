# encoding: utf-8

假設 /^有一個名稱為"([^"]*)"的專案$/ do |name|
  @project = Project.create!(:name => name)
end

