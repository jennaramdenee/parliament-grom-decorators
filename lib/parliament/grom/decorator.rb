require 'parliament/grom/decorator/version'
require 'parliament/grom/decorator/helpers'
require 'parliament/grom/decorator/constituency_area'
require 'parliament/grom/decorator/constituency_group'
require 'parliament/grom/decorator/contact_point'
require 'parliament/grom/decorator/european_region'
require 'parliament/grom/decorator/gender'
require 'parliament/grom/decorator/gender_identity'
require 'parliament/grom/decorator/house'
require 'parliament/grom/decorator/house_seat'
require 'parliament/grom/decorator/parliamentary_incumbency'
require 'parliament/grom/decorator/party'
require 'parliament/grom/decorator/party_membership'
require 'parliament/grom/decorator/person'
require 'parliament/grom/decorator/postal_address'
require 'parliament/grom/decorator/seat_incumbency'
require 'parliament/grom/decorator/parliaments'
require 'parliament/grom/decorator/member_image'
require 'parliament/grom/decorator/formal_body_membership'
require 'parliament/grom/decorator/formal_body'
require 'parliament/grom/decorator/government_incumbency'
require 'parliament/grom/decorator/government_position'
require 'parliament/grom/decorator/opposition_incumbency'
require 'parliament/grom/decorator/opposition_position'
require 'parliament/grom/decorator/web_article'
require 'parliament/grom/decorator/audience'
require 'parliament/grom/decorator/article_type'
require 'parliament/grom/decorator/collection'

# Namespace for classes and modules that handle connections to, and processing of data from the parliamentary API.
# @since 0.1.0
module Parliament
  module Grom
    # Namespace for Grom decorators.
    #
    # @since 0.1.0
    module Decorator
      # Gets the root directory of the gem
      def self.gem_path
        File.expand_path '../../../../', __FILE__
      end

      # Loads the translation file into the I18n gem
      I18n.load_path += Dir[File.join(gem_path, 'config', 'locales', '*.yml')]
      I18n.backend.load_translations

      # Decorates objects with alias methods extended from its decorator module.
      #
      # @param [Grom::Node] object the object to be decorated.
      def self.decorate(object)
        return object unless object.respond_to?(:type)

        object_type = ::Grom::Helper.get_id(object.type)

        return object unless constants.include?(object_type.to_sym)

        decorator_module = Object.const_get("Parliament::Grom::Decorator::#{object_type}")
        object.extend(decorator_module)
      end
    end
  end
end
