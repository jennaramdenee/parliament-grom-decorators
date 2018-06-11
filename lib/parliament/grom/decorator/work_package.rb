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

        ## CURRENT STUFF ##

        # @return [Bool] Whether a work package has been withdrawn.
        def withdrawn?
          # If business items have procedure step withdrawn
          # business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Withdrawal of motion') }
          # TODO: Implement
        end

        # @return [Bool] Whether a work package has expired (clock has ended).
        def expired?
          # If clock has ended
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Approval clock ends') }
          # TODO: Implement
        end

        # @return [Bool] Whether a decision has been made on an SI (approved or rejected).
        def decision_made?
          approved? || rejected?
        end

        # @return [Bool] Whether a work package has been approved.
        def approved?
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Approved') }
          # TODO: Implement
        end

        # @return [Bool] Whether a work package has been rejected.
        def rejected?
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('SI Dead') }
          # TODO: Implement
        end
      end
    end
  end
end
