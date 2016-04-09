class LinkItem
  include Listable
  attr_reader :description, :site_name

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
  end

  def format_name
    @site_name ? @site_name : ""
  end

  def details
    format_description(get_type, @description) + "site name: " + format_name
  end

  def get_type
    "link"
  end

end
