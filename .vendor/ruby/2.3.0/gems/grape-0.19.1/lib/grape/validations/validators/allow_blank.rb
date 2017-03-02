module Grape
  module Validations
    class AllowBlankValidator < Base
      def validate_param!(attr_name, params)
        return if (options_key?(:value) ? @option[:value] : @option) || !params.is_a?(Hash)

        value = params[attr_name]
        value = value.strip if value.respond_to?(:strip)

        return if false == value || value.present?

        raise Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: message(:blank)
      end
    end
  end
end
