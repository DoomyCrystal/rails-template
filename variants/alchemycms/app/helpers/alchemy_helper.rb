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
      warning("No Page found!")
      return nil
    end
    default_options = {
        title_prefix: t('meta_title', default: ""),
        title_separator: " - ",
        default_lang: "de"
    }
    options = default_options.merge(options)
    # render meta description of the root page from language if the current meta description is empty
    if @page.meta_description.blank?
      description = @root_page.try(:meta_description)
    else
      description = @page.meta_description
    end
    # render meta keywords of the root page from language if the current meta keywords is empty
    if @page.meta_keywords.blank?
      keywords = @root_page.try(:meta_keywords)
    else
      keywords = @page.meta_keywords
    end
    robot = "#{@page.robot_index? ? "" : "no"}index, #{@page.robot_follow? ? "" : "no"}follow"
    meta_string = %(
<meta charset="UTF-8">
#{render_title_tag(prefix: options[:title_prefix], separator: options[:title_separator])}
    #{render_meta_tag(name: "description", content: description)}
    #{render_meta_tag(name: "keywords", content: keywords)}
<meta name="created" content="#{@page.updated_at}">
<meta name="robots" content="#{robot}">
<meta property="og:locale" content="#{@page.language.code}#{@page.language.country_code.blank? ? '' : "_#{@page.language.country_code.upcase}" }"">
<meta property="og:type" content="website">
<meta name="twitter:title" property="og:title" content="#{render_page_title(prefix: options[:title_prefix], separator: options[:title_separator])}">
<meta name="twitter:description" property="og:description" content="#{description}">
<meta name="twitter:url" property="og:url" content="#{request.original_url}">
<meta property="og:site_name" content="#{t('meta_title', default: "")}">
<meta name="twitter:card" content="summary">
<meta name="twitter:domain" content="#{t('meta_title', default: "")}">
      )
    if @page.contains_feed?
      meta_string += %(
          <link rel="alternate" type="application/rss+xml" title="RSS" href="#{show_alchemy_page_url(@page, format: :rss)}">
        )
    end
    meta_string.html_safe
  end

  # Automatically adds srcset with 1x and 2x to the image_tag from an ingredient (EssencePicture) and a default size.
  #
  #   = retina_image_tag(el.ingredient(:picture), '200x400', 'some alt text')
  #
  # Produces:
  #
  #   <img src="/path/to/picture/200x400/cropped.jpg"
  #        srcset="/path/to/picture/200x400/cropped.jpg 1x,/path/to/picture/400x800/cropped.jpg 2x" alt="some alt text">
  #
  def retina_image_tag(ingredient, image_size, options={})
    width, height = image_size.split /x/
    default_img = show_alchemy_picture_path(ingredient, size: image_size, crop: true)
    retina_img = show_alchemy_picture_path(ingredient, size: "#{width.to_i*2}x#{height.to_i*2}", crop: true)

    image_tag default_img, options.reverse_merge(srcset: "#{default_img} 1x,#{retina_img} 2x", alt: '')
  end

end