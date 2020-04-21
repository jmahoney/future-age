module Sanitiser
  include ActiveSupport::Concern

  def sanitise(html, method)
    if method == :strict
      return strict(html)
    else
      return default(html)
    end
  end

  private

  def strict(html)
    fragment = Loofah.fragment(html).scrub!(:whitewash)
    return fragment.to_s
  end


  def default(html)
    image_attr_scrubber = Loofah::Scrubber.new do |node|
      whitelist = ["alt", "src"]
      if node.name == "img"
        node.attributes.each do |attr|
          node.remove_attribute(attr.first) unless whitelist.include?(attr.first)
        end
      end
    end

    div_attr_scrubber = Loofah::Scrubber.new do |node|
      if node.name == "div"
        node.attributes.each do |attr|
          node.remove_attribute(attr.first)
        end
      end
    end

    fragment = Loofah.fragment(html).scrub!(image_attr_scrubber).scrub!(div_attr_scrubber)

    return fragment.to_s
  end


end