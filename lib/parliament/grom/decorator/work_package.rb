module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/WorkPackage
      module WorkPackage
        # Alias workPackageHasProcedure with fallback.
        #
        # @return [Array, Array] an array of Procedure Grom::Node of the Grom::Node or an empty array.
        def procedures
          respond_to?(:workPackageHasProcedure) ? workPackageHasProcedure : []
        end

        # Alias workPackageHasBusinessItem with fallback.
        #
        # @return [Array, Array] an array of BusinessItem Grom::Nodes or an empty array.
        def business_items
          respond_to?(:workPackageHasBusinessItem) ? workPackageHasBusinessItem : []
        end

        # A list of procedural steps that have been actualised
        #
        # @return [Array, Array] an array of ProcedureStep Grom::Nodes or an empty array.
        def actualised_steps
          business_items.map(&:procedure_steps).flatten! || []
        end

        # @return [Grom::Node, nil] a BusinessItem Grom::Node representing the laying of a WorkPackage or nil .
        def laying_body
          business_items.find { |business_item| business_item.laying_body }
        end

        # @return [Grom::Node, nil] the laying date of a WorkPackage or nil .
        def laid_date
          laying_business_item.try(&:date)
        end


        # A unique list of next steps for each business item
        #
        # @return [Array, Array] a unique array of ProcedureStep Grom::Nodes for each business item.
        def next_steps
          all_next_steps = []
          business_items.each do |business_item|
            business_item.procedure_steps.each do |procedure_step|
              all_next_steps << procedure_step.potential_next_steps
            end
          end
          next_steps = all_next_steps.flatten - actualised_steps
          next_steps.uniq
        end


        ### EVERYTHING TO DO STATUS OF A WORK PACKAGE

        # @return [String, String] the status of a Work Package.
        def status
          # TODO: Implement
          if ((procedures.first.made_affirmative? || procedures.first.negative?) && expired?) || (procedures.first.draft_affirmative? && approved?)
            status = 'Approved'
          elsif rejected?
            status = 'Rejected'
          elsif withdrawn?
            status = 'Withdrawn'
          else
            status = 'In Progress'
          end
        end

        # @return [Bool] Whether a work package has been withdrawn.
        def withdrawn?
          # If business items have procedure step withdrawn
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Withdrawal of motion') }
          # TODO: Implement
        end

        # @return [Bool] Whether a work package has expired (clock has ended).
        def expired?
          # If clock has ended
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Approval clock ends') }
          # TODO: Implement
        end

        def approved?
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Approved') }
          # TODO: Implement
        end

        def rejected?
          # Draft SI dead or Already Made SI unmade
          (procedures.first.draft? && dead?) || (procedures.first.already_made? && unmade?)
          # TODO: Implement
        end

        def unmade?
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Unmade') }
          # TODO: Implement
        end

        def dead?
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('SI Dead') }
          # TODO: Implement
        end

      end
    end
  end
end
