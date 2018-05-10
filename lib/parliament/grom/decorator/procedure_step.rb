module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/ProcedureStep
      module ProcedureStep
        # Alias procedureStepName with fallback.
        #
        # @return [String, String] the name of the Grom::Node or an empty string.
        def name
          respond_to?(:procedureStepName) ? procedureStepName : ''
        end

        # Alias name with fallback.
        #
        # @return [String, String] the name of the Grom::Node or an empty string.
        def colloquial_name
          respond_to?(:procedureStepColloquialName) ? procedureStepColloquialName : ''
        end

        # Alias procedureStepHasHouse with fallback.
        #
        # @return [Array, Array] an array of House Grom::Nodes or an empty array.
        def houses
          # TODO: Implement
          respond_to?(:procedureStepHasHouse) ? procedureStepHasHouse : []
        end

        # Alias procedureStepAllowsProcedureRoute with fallback.
        #
        # @return [Array, Array] an array of AllowedProcedureRoute Grom::Nodes or an empty array.
        def allows_routes
          respond_to?(:procedureStepAllowsProcedureRoute) ? procedureStepAllowsProcedureRoute : []
        end

        # Alias procedureStepCausesProcedureRoute with fallback.
        #
        # @return [Array, Array] an array of CausedProcedureRoute Grom::Nodes or an empty array.
        def causes_routes
          respond_to?(:procedureStepCausesProcedureRoute) ? procedureStepCausesProcedureRoute : []
        end

        # @return [Array, Array] an array of ProcedureStep Grom::Nodes or an empty array.
        def potential_next_steps
          @potential_next_steps = []
          @potential_next_steps << allows_routes.map(&:steps)
          @potential_next_steps << causes_routes.map(&:steps)
          @potential_next_steps.flatten!
        end
      end
    end
  end
end
