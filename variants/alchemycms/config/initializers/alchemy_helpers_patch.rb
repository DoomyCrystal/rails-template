# Patch the Alchemy::EssencesHelper.render_essence_picture_view
# to correctly display PNGs and use the srcset-attribute for retina-images.
Alchemy::EssencesHelper.module_eval do
  def render_essence_picture_view(content, options, html_options)
    options = {
        show_caption: true,
        disable_link: false
    }.update(content.settings).update(options)
    return if content.ingredient.blank?
    if content.essence.caption.present? && options[:show_caption]
      caption = content_tag(:figcaption, content.essence.caption, id: "#{dom_id(content.ingredient)}_caption", class: "image_caption")
    end

    format, srcset = :jpeg, nil
    if content.ingredient.image_file.mime_type.end_with?('png')
      options[:format] = :png
      format = :png
    end
    width, height = options[:image_size].split /x/
    if width || height
      default_img = show_alchemy_picture_path(content.ingredient, size: options[:image_size], crop: true, format: format)
      retina_img = show_alchemy_picture_path(content.ingredient, size: "#{width ? width.to_i*2 : '' }x#{height ? height.to_i*2 : ''}", crop: true, format: format)
      srcset = "#{default_img} 1x, #{retina_img} 2x"
    end

    img_tag = image_tag(
        content.essence.picture_url(options), {
        alt: (content.essence.alt_tag.blank? ? nil : content.essence.alt_tag),
        title: (content.essence.title.blank? ? nil : content.essence.title),
        class: (caption || content.essence.css_class.blank? ? nil : content.essence.css_class),
        srcset: srcset
    }.merge(caption ? {} : html_options)
    )
    output = caption ? img_tag + caption : img_tag
    if content.essence.link.present? && !options[:disable_link]
      output = link_to(url_for(content.essence.link), {
          title: content.essence.link_title.blank? ? nil : content.essence.link_title,
          target: (content.essence.link_target == "blank" ? "_blank" : nil),
          'data-link-target' => content.essence.link_target.blank? ? nil : content.essence.link_target
      }) do
        output
      end
    end
    if caption
      content_tag(:figure, output, {class: content.essence.css_class.blank? ? nil : content.essence.css_class}.merge(html_options))
    else
      output
    end
  end
end