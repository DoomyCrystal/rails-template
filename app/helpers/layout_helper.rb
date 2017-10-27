module LayoutHelper
  # Embeds an svg directly into the DOM. Use paths as known with any asset-helper within rails.
  #
  # Usage:
  #
  #     = embedded_svg "logo.svg", class: "my-svg-class"
  #
  # Produces:
  #
  #   <svg class="svg svg--logo my-svg-class" ...>..</svg>
  #
  def embedded_svg(filename, options = {})
    doc = Nokogiri::HTML::DocumentFragment.parse(File.read(Rails.root.join('app', 'assets', 'images', filename)))
    if options[:class].present?
      doc.at_css('svg')['class'] = "svg svg--#{File.basename(filename, '.*').parameterize} #{options[:class]}"
    else
      doc.at_css('svg')['class'] = "svg svg--#{File.basename(filename, '.*').parameterize}"
    end
    raw doc
  end

  def trackable?
    Rails.env.production? && !@preview_mode && !requested_by_myself?
  end

  def requested_by_myself?
    request.remote_ip == local_ip
  end

  require 'socket'
  def local_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end
end
