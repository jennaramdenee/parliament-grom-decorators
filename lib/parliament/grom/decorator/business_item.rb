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
        # NB. One and only one group has to lay, so it will always be the first laying body
        #
        # @return [Grom::Node, nil] a Grom::Node representing the group that did the laying.
        def laying_body
          respond_to?(:layingHasLayingBody) ? layingHasLayingBody.first : nil
        end

        # A business item can have many procedural steps, each of which belongs to a house or both houses
        #
        # @return [Array, Array] an Array of all House Grom::Nodes, or an empty array.
        def procedure_steps_houses
          procedure_steps.map(&:houses).flatten.uniq
        end

        # @return [String, String] an Array of all House Grom::Nodes, or an empty array.
        def procedure_steps_house_names
          procedure_steps_houses.map(&:name).join(' and ')
        end
      end
    end
  end
end
