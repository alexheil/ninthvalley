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

  def language
    [
      ['English'],
      ['Mandarin'],
      ['Spanish'],
      ['French'],
      ['German'],
      ['Hindi'],
      ['Arabic'],
      ['Portuguese'],
      ['Bengali'],
      ['Russian'],
      ['Japanese'],
      ['Punjabi'],
      ['Wu'],
      ['Malay'],
      ['Telugu'],
      ['Vietnamese'],
      ['Turkish'],
      ['Polish'],
      ['Swedish'],
      ['Italian']
    ]
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

  def country
    [
      ['US | United States'],
      ['AT | Austria'],
      ['AU | Australia'],
      ['BE | Belgium'],
      ['CA | Canada'],
      ['DE | Germany'],
      ['DK | Denmark'],
      ['ES | Spain'],
      ['FI | Finland'],
      ['FR | France'],
      ['GB | United Kingdom'],
      ['IE | Ireland'],
      ['IT | Italy'],
      ['JP | Japan'],
      ['LU | Luxembourg'],
      ['MX | Mexico'],
      ['NL | Netherlands'],
      ['NO | Norway'],
      ['SE | Sweden']
    ]
  end

  def rating
    [
      ['5'],
      ['4'],
      ['3'],
      ['2'],
      ['1']
    ]
  end

end
