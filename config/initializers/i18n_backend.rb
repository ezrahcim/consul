I18n::Backend::Simple.send(:include, I18n::Backend::Memoize) unless Rails.env.development?
