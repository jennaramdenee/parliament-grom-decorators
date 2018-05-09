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

        # Alias businessItemDate with fallback.
        #
        # @return [Date, nil] a laying date or nil.
        def date
          respond_to?(:businessItemDate) ? DateTime.parse(businessItemDate) : nil
        end

        # Alias businessItemHasBusinessItemWebLink with fallback.
        #
        # @return [String, String] a web link to view business item Grom::Node or an empty string.
        def web_link
          respond_to?(:businessItemHasBusinessItemWebLink) ? businessItemHasBusinessItemWebLink : ''
        end

        # Alias layingHasLayingBody with fallback.
        #
        # @return [Grom::Node, nil] a Grom::Node representing the group that did the laying.
        def laying_body
          respond_to?(:layingHasLayingBody) ? layingHasLayingBody : nil
        end
      end
    end
  end
end
