module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/WorkPackage
      module WorkPackage
        # Alias workPackageName with fallback.
        #
        # @return [String, String] the name of the Grom::Node or an empty string.
        def name
          respond_to?(:workPackageName) ? workPackageName : ''
        end

        # Alias workPackageHasProcedure with fallback.
        #
        # @return [Array, Array] an array of Procedure Grom::Node of the Grom::Node or an empty array.
        def procedure
          respond_to?(:workPackageHasProcedure) ? workPackageHasProcedure : []
        end

        # Alias workPackageHasBusinessItem with fallback.
        #
        # @return [Array, Array] an array of BusinessItem Grom::Nodes or an empty array.
        def business_items
          respond_to?(:workPackageHasBusinessItem) ? workPackageHasBusinessItem : []
        end

      end
    end
  end
end
