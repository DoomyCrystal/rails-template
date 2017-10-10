module AlchemyHelper

  # Returns just the url to a picture. Keeps the aspect-ratio when cropping.
  #
  #   = background_url(content, size: '200x400', crop: true, format: :png)
  #
  # Produces:
  #
  #   www.example.com/path/to/picture/200x400/cropped.png
  #
  def background_url(content, options={})
    options = content.settings.update(options)
    return if content.ingredient.blank?
    content.essence.picture_url(options)
  end

  # Returns just the url to a picture. Forces cropping and does not preserve aspect-ratio.
  #
  #   = thumbnail_url(content, size: '200x400', crop: true, format: :png)
  #
  # Produces:
  #
  #   www.example.com/path/to/picture/200x400/cropped.png
  #
  def thumbnail_url(content, options={})
    options = content.settings.update(options)
    return if content.ingredient.blank?
    content.ingredient.url(options)
  end

end