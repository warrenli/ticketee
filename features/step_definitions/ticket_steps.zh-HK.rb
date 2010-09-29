# encoding: utf-8

假設 /^這專案有一個工作單:$/ do |table|
  table.hashes.each do |ticket|
    @project.tickets.create!(ticket)
  end
end
