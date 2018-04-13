module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/Procedure
      module Procedure
        # Alias procedureName with fallback.
        #
        # @return [String, String] the name of the Grom::Node or an empty string.
        def name
          respond_to?(:procedureName) ? procedureName : ''
        end

        # @return [Bool] whether a procedure is affirmative made.
        def affirmative_made?
          name.include?('Made Affirmative')
        end
      end
    end
  end
end
