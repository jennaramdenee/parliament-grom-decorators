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
        def made_affirmative?
          name == 'Made Affirmative'
        end

        # @return [Bool] whether a procedure is affirmative draft.
        def draft_affirmative?
          name == 'Draft Affirmative'
        end

        # @return [Bool] whether a procedure is affirmative.
        def affirmative?
          made_affirmative? || draft_affirmative?
        end

        # @return [Bool] whether a procedure is negative made.
        def made_negative?
          name == 'Made Negative'
        end

        # @return [Bool] whether a procedure is negative draft.
        def draft_negative?
          name == 'Draft Negative'
        end

        # @return [Bool] whether a procedure is negative.
        def negative?
          made_negative? || draft_negative?
        end

        # @return [Bool] whether a procedure is made.
        def already_made?
          made_affirmative? || made_negative?
        end

        # @return [Bool] whether a procedure is draft.
        def draft?
          draft_affirmative? || draft_negative?
        end

      end
    end
  end
end
