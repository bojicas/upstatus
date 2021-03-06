Given /^no admins$/ do
  Admin.delete_all
end

Given /^a service with title "([^"]*)" and description "([^"]*)"$/ do |title, description|
  Factory.create(:service, :title => title, :description => description)
end

Given /^following services$/ do |table|
  table.hashes.each do |hash|  
    Factory(:service, hash)
  end  
end

Given /^no pending issues$/ do
  Issue.delete_all
end

Given /^a current issue "([^"]*)" with severity status "([^"]*)" for "([^"]*)"$/ do |issue, severity, service|
  service = Service.where(:title => service) 
  unless service
    Given %{a service with title "#{service}" and description "Main application site"}
  end
  @issue = Factory(:issue,
    :service_id => service.first.id, 
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

Given /^the above issue has been reported on "([^"]*)"$/ do |time_down|
  unless @issue
    Given %{a number of "1" pending issues}
  end
  @issue.time_down = time_down
  @issue.save
end

Given /^the above issue has an estimate of "([^"]*)"$/ do |estimate|
  unless @issue
    Given %{a number of "1" pending issues}
  end
  @issue.estimate = estimate
  @issue.save
end

Given /^the above issue has resolved status "([^"]*)" and time up "([^"]*)"$/ do |resolved, time_up|
  unless @issue
    Given %{a number of "1" pending issues}
  end
  resolved = true if resolved == "true"
  @issue.resolved = resolved
  @issue.time_up = time_up if resolved
  @issue.save
end

Given /^the above issue has description "([^"]*)"$/ do |description|
  unless @issue
    Given %{a number of "1" pending issues}
  end
  @issue.description = description
  @issue.save
end


Then /^I should see the link "([^\"]*)"$/ do | link |
  page.should have_xpath("//a[@title=\"#{link}\"]")
end

Then /^I should see the alt text "([^\"]*)"$/ do | alt_text |
  page.should have_xpath("//img[@alt=\"#{alt_text}\"]")
end

Then /^I should see the image "([^"]*)"$/ do | image |
  page.body.should include(image)
end

Then /^I should not see the link "([^\"]*)"$/ do | link |
  page.should_not have_xpath("//a[@title=\"#{link}\"]")
end

Then /^I should not see the alt text "([^\"]*)"$/ do | alt_text |
  page.should_not have_xpath("//img[@alt=\"#{alt_text}\"]")
end

Then /^I should not see the image "([^"]*)"$/ do | image |
  page.body.should_not include(image)
end

