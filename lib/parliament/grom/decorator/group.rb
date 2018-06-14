module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/Group.
      module Group
        include Helpers::DateHelper
        # Alias member count with fallback.
        #
        # @return [Integer, nil] the count of members of the Grom::Node or nil.
        def member_count
          respond_to?(:memberCount) ? memberCount.to_i : nil
        end

        # @return [Boolean] whether the group is also a formal body.
        def formal_body?
          type.include?('https://id.parliament.uk/schema/FormalBody')
        end
      end
    end
  end
end
