module AlchemyHelper

  # --- Extended render_meta_data ---
  # Note: The value in 'meta_title' in locales will be used for the page-title.
  #
  #
  # This helper takes care of all important meta tags for your page.
  #
  # The meta data is been taken from the @page.title, @page.meta_description, @page.meta_keywords, @page.updated_at and @page.language database entries managed by the Alchemy user via the Alchemy cockpit.
  #
  # Assume that the user has entered following data into the Alchemy cockpit of the Page "home" and that the user wants that the searchengine (aka. google) robot should index the page and should follow all links on this page:
  #
  # Title = Homepage
  # Description = Your page description
  # Keywords: cms, ruby, rubyonrails, rails, software, development, html, javascript, ajax
  #
  # Then placing +render_meta_data(title_prefix: "Company", title_separator: "-")+ into the <head> part of the +pages.html.erb+ layout produces:
  #
  #   <meta charset="UTF-8">
  #   <title>Company - #{@page.title}</title>
  #   <meta name="description" content="Your page description">
  #   <meta name="keywords" content="cms, ruby, rubyonrails, rails, software, development, html, javascript, ajax">
  #   <meta name="created" content="Tue Dec 16 10:21:26 +0100 2008">
  #   <meta name="robots" content="index, follow">
  #   <meta property="og:locale" content="de_CH">
  #   <meta property="og:type" content="website">
  #   <meta property="og:title" content="Homepage">
  #   <meta property="og:description" content="Your page description">
  #   <meta property="og:url" content="http://www.company.com">
  #   <meta property="og:site_name" content="Company">
  #   <meta name="twitter:card" content="summary">
  #   <meta name="twitter:description" content="Your page description">
  #   <meta name="twitter:title" content="Homepage">
  #   <meta name="twitter:domain" content="Company">
  #
  def render_extended_meta_data options={}
    if @page.blank?
      warning('No Page found!')
      return nil
    end
    default_options = {
        title_prefix: t('meta_title', default: ""),
        title_separator: ' - ',
        default_lang: 'de'
    }
    options = default_options.merge(options)
    # render meta description of the root page from language if the current meta description is empty
    if @page.meta_description.blank?
      description = Alchemy::Language.current_root_page.try(:meta_description)
    else
      description = @page.meta_description
    end
    # render meta keywords of the root page from language if the current meta keywords is empty
    if @page.meta_keywords.blank?
      keywords = Alchemy::Language.current_root_page.try(:meta_keywords)
    else
      keywords = @page.meta_keywords
    end
    meta_string = %(
      #{tag(:meta, charset: 'utf-8')}
      #{render_title_tag(prefix: options[:title_prefix], separator: options[:title_separator])}
      #{render_meta_tag(name: 'created', content: @page.updated_at)}
      #{render_meta_tag(name: 'robots', content: "#{@page.robot_index? ? "" : "no"}index, #{@page.robot_follow? ? "" : "no"}follow")}
      #{tag(:meta, property: 'og:locale', content: "#{@page.language.code}#{@page.language.country_code.blank? ? '' : "_#{@page.language.country_code.upcase}" }")}
      #{tag(:meta, property: 'og:type', content: 'website')}
      #{tag(:meta, name: 'twitter:title', property: 'og:title', content: render_page_title(prefix: options[:title_prefix], separator: options[:title_separator]))}
      #{tag(:meta, name: 'twitter:url', property: 'og:url', content: request.original_url)}
      #{tag(:meta, property: 'og:site_name', content: t('meta_title', default: ''))}
      #{tag(:meta, name: 'twitter:card', content: 'summary')}
      #{tag(:meta, name: 'twitter:domain', content: t('meta_title', default: ''))}
    )
    if description.present?
      meta_string += %(
        #{render_meta_tag(name: 'description', content: description.html_safe)}
        #{tag(:meta, name: 'twitter:description', property: 'og:description', content: description.html_safe)}
      )
    end
    if keywords.present?
      meta_string += %(
        #{render_meta_tag(name: 'keywords', content: keywords)}
      )
    end
    if @page.contains_feed?
      meta_string += %(
        #{auto_discovery_link_tag(:rss, show_alchemy_page_url(@page, format: :rss))}
      )
    end
    meta_string.html_safe
  end

  # Returns just the url to a picture but with the correct format as the original render_essence_picture_view.
  #
  #   = content_background_url(content, image_size: '200x400', crop: true, format: :png)
  #
  # Produces:
  #
  #   www.example.com/path/to/picture/200x400/cropped.png
  #
  def content_background_url(content, options)
    options = content.settings.update(options)

    return unless content.ingredient

    if content.ingredient.image_file.mime_type.end_with?('png')
      options[:format] = :png
    end

    show_alchemy_picture_url(content.ingredient, options)
  end

end