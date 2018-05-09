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
        #
        # @return [Grom::Node, nil] a WorkPackage Grom::Node or nil.
        def work_package
          respond_to?(:workPackageableThingHasWorkPackage) ? workPackageableThingHasWorkPackage : nil
        end

        # Alias workPackageableThingHasWorkPackage with fallback.
        #
        # @return [String, String] a web link or an empty string.
        def web_link
          respond_to?(:workPackageableThingHasWorkPackageableThingWebLink) ? workPackageableThingHasWorkPackageableThingWebLink : ''
        end
      end
    end
  end
end
