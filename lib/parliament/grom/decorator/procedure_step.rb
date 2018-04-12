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

        # Alias procedureStepAllowsProcedureRoute with fallback.
        #
        # @return [Array, Array] an array of ProcedureRoute Grom::Nodes or an empty array.
        def potential_next_routes
          respond_to?(:procedureStepAllowsProcedureRoute) ? procedureStepAllowsProcedureRoute : []
        end

        def potential_next_steps
          @potential_next_steps ||= potential_next_routes.map(&:step).flatten!
        end
      end
    end
  end
end
