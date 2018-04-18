module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/CausedProcedureRoute
      module CausedProcedureRoute
        # Alias procedureRouteIsToProcedureStep with fallback.
        #
        # @return [Array, Array] a ProcedureStep Grom::Node or nil.
        def step
          respond_to?(:procedureRouteIsToProcedureStep) ? procedureRouteIsToProcedureStep : nil
        end
      end
    end
  end
end
