module AlchemyHelper

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

    return if content.ingredient.blank?

    content.essence.picture_url(options)
  end

end