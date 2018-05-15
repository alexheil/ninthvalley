module ApplicationHelper

  def resource_name
    :instructor
  end

  def resource
    @resource ||= Instructor.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:instructor]
  end

  def resource_name_student
    :student
  end

  def resource_student
    @resource ||= Student.new
  end

  def devise_mapping_student
    @devise_mapping ||= Devise.mappings[:student]
  end

end
