SitemapGenerator::Sitemap.default_host = Rails.configuration.action_mailer.asset_host
SitemapGenerator::Interpreter.send :include, Alchemy::Engine.routes.url_helpers
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  Alchemy::Language.published.pluck(:language_code).each do |locale|
    group(:filename => locale) do
      Alchemy::Page.sitemap.where(language_code: locale).find_each do |page|
        add show_page_path({urlname: page.urlname, locale: locale}), lastmod: page.updated_at
      end
    end
  end
end
