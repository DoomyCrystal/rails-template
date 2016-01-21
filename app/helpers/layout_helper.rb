module LayoutHelper
  # Used to achieve nested layouts without content_for. This helper relies on
  # Rails internals, so beware that it make break with future major versions
  # of Rails. Inspired by http://stackoverflow.com/a/18214036
  #
  # Usage: For example, suppose "child" layout extends "parent" layout.
  # Use <%= yield %> as you would with non-nested layouts, as usual. Then on
  # the very last line of layouts/child.html.erb, include this:
  #
  #     <% parent_layout "parent" %>
  #
  def parent_layout(layout)
    @view_flow.set(:layout, output_buffer)
    output = render(:file => "layouts/#{layout}")
    self.output_buffer = ActionView::OutputBuffer.new(output)
  end

  # Embeds an svg directly into the DOM. Use paths as known with any asset-helper within rails.
  #
  # Usage:
  #
  #     = embedded_svg "logo.svg", class: "my-svg-class"
  #
  def embedded_svg(filename, options = {})
    file = Rails.application.assets.find_asset(filename).body.force_encoding("UTF-8")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    if options[:class].present?
      doc.at_css("svg")["class"] = options[:class]
    end
    raw doc
  end
end
