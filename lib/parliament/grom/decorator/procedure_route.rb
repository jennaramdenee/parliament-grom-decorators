module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/ProcedureRoute
      module ProcedureRoute
        # Alias procedureRouteIsToProcedureStep with fallback.
        #
        # @return [Array, Array] an array of ProcedureStep Grom::Nodes or an empty array.
        def steps
          respond_to?(:procedureRouteIsToProcedureStep) ? procedureRouteIsToProcedureStep : []
        end
      end
    end
  end
end
