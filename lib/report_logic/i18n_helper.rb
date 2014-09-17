module ReportLogic
  module I18nHelper
    def i18n_lookup(scope, key, default: key.to_sym, resource_class: nil, **options)
      lookup = if resource_class
        :"#{resource_class.to_s.downcase.underscore}.#{key}"
      else
        key
      end
      I18n.t(lookup, scope: [:report, scope], default: default, **options)
    end
  end
end
