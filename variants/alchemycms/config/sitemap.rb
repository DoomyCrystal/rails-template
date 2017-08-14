# Set the host name for URL creation
default_host = Rails.configuration.action_mailer.asset_host

SitemapGenerator::Sitemap.default_host = default_host
SitemapGenerator::Interpreter.send :include, Alchemy::Engine.routes.url_helpers
SitemapGenerator::Sitemap.create_index = false
SitemapGenerator::Sitemap.include_root = false
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  # Add root-page
  #
  root_page = Alchemy::Language.default.root_page
  add '/',
      lastmod: root_page.updated_at,
      alternates: Alchemy::Language.published.pluck(:language_code)
                      .map { |locale| { href: "#{default_host}/#{locale}", lang: locale } }


  # Add all sites
  #
  Alchemy::Page.sitemap.each do |page|
    add show_page_path(urlname: page.urlname, locale: page.language_code), lastmod: page.updated_at
  end

  # # Create a separate sitemap with news.
  # #
  # group filename: :news do
  #   Alchemy::Page.sitemap.where(page_layout: 'news_article').where('alchemy_pages.created_at >= ?', 2.days.ago).each do |page|
  #     add show_page_path(urlname: page.urlname, locale: page.language_code), news: {
  #         publication_name: 'FAIRMED News',
  #         publication_language: page.language_code,
  #         title: page.title,
  #         publication_date: page.elements.available.named(:news_type).first.content_by_name(:published_at)&.ingredient || page.published_at
  #     }
  #   end
  # end
end