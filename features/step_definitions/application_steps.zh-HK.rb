# encoding: utf-8

那麼 /^我應該看到"([^"]*)"鏈接$/ do |text|
  css("a").detect { |a| a.text == text }.should_not(be_nil,
    "Expected to see the #{text.inspect} link, but did not.")
end

那麼 /^我應該不會看到"([^"]*)"鏈接$/ do |text|
  css("a").detect { |a| a.text == text }.should(be_nil,
    "Expected to not see the #{text.inspect} link, but did.")
end
