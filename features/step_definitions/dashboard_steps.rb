Given /^a service with title "([^"]*)" and description "([^"]*)"$/ do |title, description|
  Service.create(:title => title, :description => description)
end

Given /^following services$/ do |table|
  table.hashes.each do |hash|  
    Service.create(hash)
  end  
end

