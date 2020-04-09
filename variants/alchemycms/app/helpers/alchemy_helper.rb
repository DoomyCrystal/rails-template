module AlchemyHelper

  def lazy_load_picture_tag(ingredient, options = {}, html_options = {})
    return if ingredient.blank?

    if html_options.key?(:class)
      html_options[:class] += ' lazyload'
    else
      html_options[:class] = 'lazyload'
    end
    html_options[:loading] ||= 'lazy'

    if options.key?(:size)
      original_width, original_height = options[:size].split /x/
      retina_options = options.merge({ size: "#{original_width.to_i * 2}x#{original_height.to_i * 2}" })

      %(<picture>
          <source data-srcset="#{ingredient.url(options.merge(format: 'webp'))} 1x, #{ingredient.url(retina_options.merge(format: 'webp'))} 2x" type="image/webp">
          <source data-srcset="#{ingredient.url(options)} 1x, #{ingredient.url(retina_options)} 2x">
          #{tag :img, html_options.merge('data-src': ingredient.url(options))}
          <noscript>#{image_tag ingredient.url(options), html_options}</noscript>
        </picture>).html_safe
    else
      %(<picture>
          <source data-srcset="#{ingredient.url(options.merge(format: 'webp'))}" type="image/webp">
          <source data-srcset="#{ingredient.url(options)}">
          #{tag :img, html_options.merge('data-src': ingredient.url(options))}
          <noscript>#{image_tag ingredient.url(options), html_options}</noscript>
        </picture>).html_safe
    end
  end

end
