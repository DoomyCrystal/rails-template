namespace :alchemy do
  desc "Flush Alchemy Page Cache"
  task flush: :environment do
    Alchemy::Page.flushables.update_all(published_at: Time.current)
    Alchemy::Page.flushable_layoutpages.update_all(published_at: Time.current)
  end

end
