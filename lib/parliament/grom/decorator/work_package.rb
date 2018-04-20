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

        # A list of procedural steps that have been actualised
        #
        # @return [Grom::Node, nil] an array of ProcedureStep Grom::Nodes or an empty array.
        def actualised_steps
          business_items.map(&:procedure_steps).flatten!
        end

        # Determining if there is a Business Item object actualising 'Laying into Commons' procedural step.
        #
        # @return [Grom::Node, nil] a BusinessItem Grom::Node or nil.
        def laid_date
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Laying into Commons') }&.date
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

        ### EVERYTHING TO DO WITH TRACKING A WORK PACKAGE

        # @return [Bool] Whether a work package has been laid in the House of Commons.
        def laid_in_commons?
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Laying into Commons') }.present?
        end

        # @return [Bool] Whether a work package has been laid in the House of Lords.
        def laid_in_lords?
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Laying into Lords') }.present?
        end

        ### EVERYTHING TO DO STATUS OF A WORK PACKAGE

        # @return [String, String] the status of a Work Package.
        def status
          # TODO: Implement
          if ((procedure.first.made_affirmative? || procedure.first.negative?) && expired?) || (procedure.first.draft_affirmative? && approved?)
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
          (procedure.first.draft? && dead?) || (procedure.first.already_made? && unmade?)
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
