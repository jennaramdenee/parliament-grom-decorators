module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/BusinessItem
      module BusinessItem
        include Helpers::DateHelper
        # Alias businessItemHasProcedureStep with fallback.
        #
        # @return [Array, Array] an array of ProcedureStep Grom::Nodes of the Grom::Node or an empty array.
        def procedure_steps
          respond_to?(:businessItemHasProcedureStep) ? businessItemHasProcedureStep : []
        end

        # Alias layingDate with fallback.
        #
        # @return [Date, nil] a laying date or nil.
        def laying_date
          respond_to?(:layingDate) ? DateTime.parse(layingDate) : nil
        end
      end
    end
  end
end
