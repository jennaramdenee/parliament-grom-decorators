module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/WorkPackage
      module WorkPackage
        include Helpers::DateHelper
        # Alias workPackageHasProcedure with fallback.
        # NB: Currently, work packages only have one procedure
        #
        # @return [Grom::Node, nil] a Procedure Grom::Node of the Grom::Node or nil.
        def procedure
          respond_to?(:workPackageHasProcedure) ? workPackageHasProcedure.first : nil
        end

        # Alias workPackageHasWorkPackageableThing with fallback.
        # NB: Currently, work packages only have one work packageable thing
        #
        # @return [Grom::Node, nil] a Procedure Grom::Node of the Grom::Node or nil.
        def work_packageable_thing
          respond_to?(:workPackageHasWorkPackageableThing) ? workPackageHasWorkPackageableThing.first : nil
        end

        # @return [String, nil] the name of the Grom::Node or an empty string.
        def work_packageable_thing_name
          work_packageable_thing&.name
        end

        # Alias workPackageHasBusinessItem with fallback.
        #
        # @return [Array, Array] an array of BusinessItem Grom::Nodes or an empty array.
        def business_items
          respond_to?(:workPackageHasBusinessItem) ? workPackageHasBusinessItem : []
        end

        # Alias oldestBusinessItemDate with fallback.
        #
        # @return [Date, nil] a date or nil.
        def oldest_business_item_date
          respond_to?(:oldestBusinessItemDate) ? DateTime.parse(oldestBusinessItemDate) : nil
        end
      end
    end
  end
end
