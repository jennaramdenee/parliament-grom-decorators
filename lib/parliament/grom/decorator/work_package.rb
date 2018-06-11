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

        def current?
          !(expired? || withdrawn? || decision_made?)
        end

        # @return [Bool] Whether a work package has been withdrawn.
        def withdrawn?
          # TODO: Implement
        end

        # Method checks to see whether procedure steps have been actualised by business items
        #
        # @return [Bool] Whether a work package has expired.
        # @note 'g8B3R2Ou' represents end of 40 day time limit to move a negative resolution (negative SIs)
        # @note 'Ksnj7JJ8' represents end of time limit for approval (made affirmative SIs)

        def expired?
          (business_item.procedure_steps.map(&:graph_id) & ['g8B3R2Ou', 'Ksnj7JJ8']).any?
        end

        # @return [Bool] Whether a decision has been made on an SI (approved or rejected).
        def decision_made?
          approved? || rejected?
        end

        # Method checks to see whether procedure steps have been actualised by business items
        #
        # @return [Bool] Whether a work package has been approved by either both houses, or by the House of Commons.
        # @note 'FYeLHMEw' represents approval by both houses
        # @note '0XYsDfhL' represents approval by the House of Commons (if a Commons only SI)
        #
        def approved?
          (business_item.procedure_steps.map(&:graph_id) & ['FYeLHMEw', '0XYsDfhL']).any?
        end

        # Method checks to see whether procedure steps have been actualised by business items
        #
        # @return [Bool] Whether a work package has been rejected.
        # @note '60eN08eS' represents instrument rejected and ceases to be law (for made affirmative SIs)
        # @note 'pJMUACWK' represents instrument annulled (for made negative SIs)
        # @note 'Z7EekLUl' represents instrument cannot be made law (for draft SIs)
        #
        def rejected?
          (business_item.procedure_steps.map(&:graph_id) & ['60eN08eS', 'pJMUACWK', 'Z7EekLUl']).any?
        end
      end
    end
  end
end
