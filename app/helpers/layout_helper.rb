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
end
