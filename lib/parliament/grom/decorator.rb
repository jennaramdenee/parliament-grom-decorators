require 'parliament/grom/decorator/version'
require 'parliament/grom/decorator/helpers'
require 'parliament/grom/decorator/answer'
require 'parliament/grom/decorator/answering_body_allocation'
require 'parliament/grom/decorator/article_type'
require 'parliament/grom/decorator/audience'
require 'parliament/grom/decorator/business_item'
require 'parliament/grom/decorator/collection'
require 'parliament/grom/decorator/concept'
require 'parliament/grom/decorator/constituency_area'
require 'parliament/grom/decorator/constituency_group'
require 'parliament/grom/decorator/contact_point'
require 'parliament/grom/decorator/european_region'
require 'parliament/grom/decorator/formal_body'
require 'parliament/grom/decorator/formal_body_chair'
require 'parliament/grom/decorator/formal_body_membership'
require 'parliament/grom/decorator/formal_body_type'
require 'parliament/grom/decorator/gender'
require 'parliament/grom/decorator/gender_identity'
require 'parliament/grom/decorator/government_incumbency'
require 'parliament/grom/decorator/government_position'
require 'parliament/grom/decorator/gov_register_government_organisation'
require 'parliament/grom/decorator/group'
require 'parliament/grom/decorator/house'
require 'parliament/grom/decorator/house_seat'
require 'parliament/grom/decorator/incumbency'
require 'parliament/grom/decorator/member_image'
require 'parliament/grom/decorator/parliamentary_incumbency'
require 'parliament/grom/decorator/parliaments'
require 'parliament/grom/decorator/party'
require 'parliament/grom/decorator/party_membership'
require 'parliament/grom/decorator/person'
require 'parliament/grom/decorator/position'
require 'parliament/grom/decorator/postal_address'
require 'parliament/grom/decorator/procedure'
require 'parliament/grom/decorator/procedure_route'
require 'parliament/grom/decorator/procedure_step'
require 'parliament/grom/decorator/question'
require 'parliament/grom/decorator/seat_incumbency'
require 'parliament/grom/decorator/opposition_incumbency'
require 'parliament/grom/decorator/opposition_position'
require 'parliament/grom/decorator/web_article'
require 'parliament/grom/decorator/work_package'
require 'parliament/grom/decorator/work_packageable_thing'

# Namespace for classes and modules that handle connections to, and processing of data from the parliamentary API.
# @since 0.1.0
module Parliament
  module Grom
    # Namespace for Grom decorators.
    #
    # @since 0.1.0
    module Decorator
      MAPPING = {
        'ConstituencyArea'                  => ConstituencyArea,
        'ConstituencyGroup'                 => ConstituencyGroup,
        'ContactPoint'                      => ContactPoint,
        'EuropeanRegion'                    => EuropeanRegion,
        'Gender'                            => Gender,
        'GenderIdentity'                    => GenderIdentity,
        'House'                             => House,
        'HouseSeat'                         => HouseSeat,
        'MemberImage'                       => MemberImage,
        'ParliamentPeriod'                  => ParliamentPeriod,
        'ParliamentaryIncumbency'           => ParliamentaryIncumbency,
        'Party'                             => Party,
        'PartyMembership'                   => PartyMembership,
        'Person'                            => Person,
        'PostalAddress'                     => PostalAddress,
        'SeatIncumbency'                    => SeatIncumbency,
        'FormalBodyMembership'              => FormalBodyMembership,
        'FormalBody'                        => FormalBody,
        'FormalBodyType'                    => FormalBodyType,
        'GovernmentIncumbency'              => GovernmentIncumbency,
        'GovernmentPosition'                => GovernmentPosition,
        'OppositionIncumbency'              => OppositionIncumbency,
        'OppositionPosition'                => OppositionPosition,
        'WebArticle'                        => WebArticle,
        'Audience'                          => Audience,
        'ArticleType'                       => ArticleType,
        'Collection'                        => Collection,
        'Concept'                           => Concept,
        'Incumbency'                        => Incumbency,
        'Group'                             => Group,
        'GovRegisterGovernmentOrganisation' => GovRegisterGovernmentOrganisation,
        'Position'                          => Position,
        'FormalBodyChair'                   => FormalBodyChair,
        'WorkPackage'                       => WorkPackage,
        'WorkPackageableThing'              => WorkPackageableThing,
        'Procedure'                         => Procedure,
        'ProcedureStep'                     => ProcedureStep,
        'ProcedureRoute'                    => ProcedureRoute,
        'BusinessItem'                      => BusinessItem,
        'Question'                          => Question,
        'Answer'                            => Answer,
        'AnsweringBodyAllocation'           => AnsweringBodyAllocation
      }.freeze

      class << self
        # Gets the root directory of the gem
        def gem_path
          File.expand_path '../../..', __dir__
        end

        def load!
          # Loads the translation file into the I18n gem
          I18n.load_path += Dir[File.join(gem_path, 'config', 'locales', '*.yml')]
          I18n.backend.load_translations
        end

        # Decorates objects with alias methods extended from its decorator module.
        #
        # @param [Grom::Node] object the object to be decorated.
        def decorate(object)
          return object unless object.respond_to?(:type)

          Array(object.type).each do |type|
            decorator = MAPPING[::Grom::Helper.get_id(type)] # Get the decorator for a type, or nil

            object.extend(decorator) unless decorator.nil?
          end

          object
        end
      end
    end
  end
end

Parliament::Grom::Decorator.load!
