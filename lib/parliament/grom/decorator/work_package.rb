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

        # Determining if there is a Business Item object actualising 'Laying into Commons' procedural step.
        #
        # @return [Grom::Node, nil] a BusinessItem Grom::Node or nil.
        def laid_in_commons_business_item
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Laying into Commons') }
        end

        # Determining if there is a Business Item object actualising 'Laying into Lords' procedural step.
        #
        # @return [Grom::Node, nil] a BusinessItem Grom::Node or nil.
        def laid_in_lords_business_item
          business_items.find { |business_item| business_item.procedure_steps.map(&:name).include?('Laying into Lords') }
        end

        ### EVERYTHING TO DO WITH TRACKING AND STATUS OF A WORK PACKAGE

        # @return [String, String] the status of a Work Package.
        def status
          # TODO: Implement
          # if withdrawn?
          #   status = 'Withdrawn'
          # elsif expired? || made?
          #   status = 'Closed'
          # else
          #   status = 'In Progress'
          # end
        end

        # @return [Bool] Whether a work package has been laid in the House of Commons.
        def laid_in_commons?
          laid_in_commons_business_item.present?
        end

        # @return [Bool] Whether a work package has been laid in the House of Lords.
        def laid_in_lords?
          laid_in_lords_business_item.present?
        end

        # @return [Bool] Whether a work package has been withdrawn.
        def withdrawn?
          # TODO: Implement
        end

        # @return [Bool] Whether a work package has expired (clock has ended).
        def expired?
          # TODO: Implement
        end

        # @return [Bool] Whether a work package has been made (brought into law).
        def made?
          # TODO: Implement
        end
      end
    end
  end
end
