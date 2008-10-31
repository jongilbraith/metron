module Metron
  module Support
  
    # Ripped off of ActiveSupport
    def pluralize(count, singular, plural = nil)
      "#{count || 0} " + ((count == 1 || count == '1') ? singular : (plural || ActiveSupport::Inflector.pluralize(singular)))
    end
  
  end
end