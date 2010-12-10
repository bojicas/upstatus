Given /^an admin "([^"]*)" with password "([^"]*)"$/ do |admin, password|
  Admin.create(:email => admin, :password => password, :password_confirmation => password)
end

Given /^an authenticated admin$/ do
  email = "admin@cubicleapps.com"
  password = "secretpass"

  Given %{an admin "#{email}" with password "#{password}"}
  And %{I go to the sign in page}
  And %{I fill in "admin_email" with "#{email}"}
  And %{I fill in "admin_password" with "#{password}"}
  And %{I press "Sign in"}
end

