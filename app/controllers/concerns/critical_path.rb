module CriticalPath
  extend ActiveSupport::Concern

  # Adjust this to match the current-project
  included do
    before_action :fetch_critical_css, if: -> {Rails.env.production? && controller_name == 'pages' && %w[index show].include?(action_name)}
  end

  def fetch_critical_css
    @critical_css = request.get? ? CriticalPathCss.fetch(request.path) : ''
    GenerateCriticalCssJob.perform_later(request.path) if @critical_css.empty?
    @critical_css
  end
end