module RelativeUrlResolver
  include ActiveSupport::Concern

  def resolve_urls(html, website_url)
    relative_url_scrubber = Loofah::Scrubber.new do |node|
      if node.name == "img"
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

  def absolute(img, website_url)
    puts website_url
    uri = URI.parse(img)
    return img if uri.scheme.present?

    uri = URI.parse(website_url)

    if img.start_with?("/")
      return "#{uri.scheme}://#{uri.host}#{img}"
    end


    if uri.path.present? && uri.path != "/"
      puts "really?"
      full_path = uri.path.end_with?("/") ? "#{uri.path}#{img}" : "#{uri.path}/#{img}"
      puts "come on"
      return "#{uri.scheme}://#{uri.host}#{full_path}"
    end


    puts "I got here instead"

    return "#{uri.scheme}://#{uri.host}/#{img}"
  end

end