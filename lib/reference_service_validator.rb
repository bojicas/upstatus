class ReferenceServiceValidator < ActiveModel::EachValidator  
  def validate_each(object, attribute, value)  
    if Service.where(:id => value).empty?
      object.errors[attribute] << ("is not referencing to an existing service")  
    end  
  end  
end  

