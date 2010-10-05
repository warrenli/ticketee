# encoding: utf-8

假設 /^"([^"]*)"可以閱讀"([^"]*)"專案$/ do |user, project|
  create_permission(user, find_project(project), "read")
end

假設 /^"([^"]*)"可以建立"([^"]*)"專案的工作單$/ do |user, project|
  create_permission(user, find_project(project), "create tickets")
end

假設 /^"([^"]*)"可以修改"([^"]*)"專案的工作單$/ do |user, project|
  create_permission(user, find_project(project), "edit tickets")
end

假設 /^"([^"]*)"可以刪除"([^"]*)"專案的工作單$/ do |user, project|
  create_permission(user, find_project(project), "delete tickets")
end

當 /^我在"([^"]*)"的"([^"]*)"框打勾$/ do |name, permission|
  project = Project.find_by_name!(name)
  steps(%Q{When I check "permissions_#{project.id}_#{permission.downcase.gsub(" ", "_")}"})
end

def create_permission(email, object, action)
  Permission.create!(:user => User.find_by_email!(email), :object => object, :action => action)
end

def find_project(name)
  Project.find_by_name!(name)
end
