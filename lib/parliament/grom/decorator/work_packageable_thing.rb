module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/WorkPackageableThing
      module WorkPackageableThing
        # Alias workPackageableThingName with fallback.
        #
        # @return [String, String] the name of the Grom::Node or an empty string.
        def name
          respond_to?(:workPackageableThingName) ? workPackageableThingName : ''
        end

        # Alias workPackageableThingHasWorkPackage with fallback.
        # NB: Currently, a work packageable thing only has one work package
        #
        # @return [Grom::Node, nil] a WorkPackage Grom::Node or nil.
        def work_package
          respond_to?(:workPackageableThingHasWorkPackage) ? workPackageableThingHasWorkPackage.first : nil
        end

        # Alias workPackageableThingHasWorkPackage with fallback.
        #
        # @return [String, String] a web link or an empty string.
        def web_link
          respond_to?(:workPackageableThingHasWorkPackageableThingWebLink) ? workPackageableThingHasWorkPackageableThingWebLink : ''
        end

        # Alias workPackageableThingComingIntoForceDate with fallback.
        #
        # @return [DateTime, nil] the date a work package has come into force or nil.
        def coming_into_force_date
          respond_to?(:workPackageableThingComingIntoForceDate) ? DateTime.parse(workPackageableThingComingIntoForceDate) : nil
        end

        # Alias workPackageableThingComingIntoForceDate with fallback.
        #
        # @return [DateTime, nil] the expiry date (time limit) of a work package or nil.
        def time_limit_for_objection_date
          respond_to?(:workPackageableThingTimeLimitForObjectionEndDate) ? DateTime.parse(workPackageableThingTimeLimitForObjectionEndDate) : nil
        end
      end
    end
  end
end
