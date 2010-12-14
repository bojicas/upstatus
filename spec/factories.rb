FactoryGirl.define do
  factory :admin do
    email "admin@cubicleapps.com"
    password "secretpass"
  end

  factory :service do
    title "cubicleapps.com - main"
  end

  factory :issue do
    service
    title "Hardware Failure"
    severity 5
    resolved false
  end
end
