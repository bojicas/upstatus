Given /^no admins$/ do
  Admin.delete_all
end

Given /^a service with title "([^"]*)" and description "([^"]*)"$/ do |title, description|
  Service.create(:id => 1, :title => title, :description => description)
end

Given /^following services$/ do |table|
  table.hashes.each do |hash|  
    Service.create(hash)
  end  
end

Given /^no pending issues$/ do
  Issue.delete_all
end

Given /^a current issue "([^"]*)" with severity status "([^"]*)" for "([^"]*)"$/ do |issue, severity, service|
  Issue.create(
    :service_id => Service.where(:title => service).first.id, 
    :title => issue, 
    :severity => severity, 
    :resolved => false,
    :time_down => DateTime.now - 2.hours,
    :time_up => DateTime.now
  )
end

Given /^a number of "([^"]*)" pending issues$/ do |pending_issues|
  Given %{a service with title "cubicleapps.com - main" and description "Main application site"}
  iterator = 1
  pending_issues.to_i.times do
    Given %{a current issue "Hardware Failure no #{iterator}" with severity status "4" for "cubicleapps.com - main"}
    iterator += 1
  end
end

