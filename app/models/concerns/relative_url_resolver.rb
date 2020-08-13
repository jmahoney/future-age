module RelativeUrlResolver
  include ActiveSupport::Concern

  def resolve_urls(html, website_url)

    relative_url_scrubber = Loofah::Scrubber.new do |node|
      if ["img", "a"].include?(node.name) 
        node.attributes.find_all{|a| a[0] == "src"}.each do |src|
          absolute_url = absolute(src[1].to_s, website_url)
          if absolute_url != src[0]
            node.set_attribute("src", absolute_url)
          end
        end
      end
    end

    fragment = Loofah.fragment(html).scrub!(relative_url_scrubber)
    return fragment.to_s
  end


  private

  def absolute(src, website_url)
    uri = Addressable::URI.parse(src)
    return src if uri.scheme.present?

    if src.start_with?("//") 
      return "https:#{src}"
    end

    uri = Addressable::URI.parse(website_url)

    if src.start_with?("/")
      return "#{uri.scheme}://#{uri.host}#{src}"
    end

    if uri.path.present? && uri.path != "/"

      full_path = uri.path.end_with?("/") ? "#{uri.path}#{src}" : "#{uri.path}/#{src}"

      return "#{uri.scheme}://#{uri.host}#{full_path}"
    end

    return "#{uri.scheme}://#{uri.host}/#{src}"
  end

end