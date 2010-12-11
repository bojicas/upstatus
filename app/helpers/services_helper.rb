module ServicesHelper
  def status(service)
    if service.issues.current_issues.count == 0
      "(UP)"
    else
      "(DOWN - #{pluralize(service.issues.current_issues.count, "issue")})" 
    end
  end
end
