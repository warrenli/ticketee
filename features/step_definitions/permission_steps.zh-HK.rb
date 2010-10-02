# encoding: utf-8

假設 /^"([^"]*)"可以閱讀"([^"]*)"專案$/ do |user, project|
  Permission.create(:user => User.find_by_email!(user), :object => Project.find_by_name(project), :action => 'read')
end
