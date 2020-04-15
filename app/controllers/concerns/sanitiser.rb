module Sanitiser
  include ActiveSupport::Concern

  def sanitise(html, method)
    if method == :strict
      return strict(html)
    else
      return html
    end
  end

  private

  def strict(html)
    fragment = Loofah.fragment(html).scrub!(:whitewash)
    return fragment.to_s
  end

end