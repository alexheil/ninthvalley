module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Ninth Valley"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

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

  def currency
    [
      ['USD'],
      ['AUD'],
      ['CAD'],
      ['CHF'],
      ['DKK'],
      ['EUR'],
      ['GBP'],
      ['JPY'],
      ['MXN'],
      ['NOK'],
      ['SEK'],
      ['SGD']
    ]
  end

end
