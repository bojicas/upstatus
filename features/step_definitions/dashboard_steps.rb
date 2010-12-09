Given /^I have a service with title "([^"]*)" and description "([^"]*)"$/ do |title, description|
  Service.create(:title => title, :description => description)
end

