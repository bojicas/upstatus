Given /^I have a service with title "([^"]*)" and description "([^"]*)"$/ do |arg1, arg2|
  Service.create(:title => "cubicleapps.com - main", :description => "Main application site")
end

