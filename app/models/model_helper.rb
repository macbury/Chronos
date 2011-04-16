class ModelHelper
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper
  default_url_options[:host] = RhCore::Config["host"]
  
  def self.method_missing(method_sym, *arguments, &block)
    m = ModelHelper.new
    m.send(method_sym, *arguments) if m.respond_to?(method_sym)
  end
end
