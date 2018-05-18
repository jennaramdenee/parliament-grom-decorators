module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/WorkPackage
      module WorkPackage
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

        # Alias workPackageHasBusinessItem with fallback.
        #
        # @return [Array, Array] an array of BusinessItem Grom::Nodes or an empty array.
        def business_items
          respond_to?(:workPackageHasBusinessItem) ? workPackageHasBusinessItem : []
        end

        # The business item representing the laying of a work packageable thing
        #
        # @return [Grom::Node, nil] a BusinessItem Grom::Node or nil.
        def laying_business_item
          business_items.find { |business_item| business_item.laying_body.present? }
          # respond_to?(:layableThingHasLaying) ? layableThingHasLaying.first : nil
        end

        # A list of procedural steps that have been actualised
        #
        # @return [Array, Array] an array of ProcedureStep Grom::Nodes or an empty array.
        def actualised_steps
          business_items.map(&:procedure_steps).flatten! || []
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
          if ((procedure.made_affirmative? || procedure.negative?) && expired?) || (procedure.draft_affirmative? && approved?)
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
          (procedure.draft? && dead?) || (procedure.already_made? && unmade?)
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
