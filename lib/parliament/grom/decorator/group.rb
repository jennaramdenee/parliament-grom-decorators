module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/Group.
      module Group
        include Helpers::DateHelper
        # Alias groupName with fallback.
        #
        # @return [String, String] the name of the Grom::Node or an empty string.
        def name
          respond_to?(:groupName) ? groupName : ''
        end

        # Alias groupStartDate with fallback.
        #
        # @return [DateTime, nil] the start date of the Grom::Node or nil.
        def start_date
          @start_date ||= respond_to?(:groupStartDate) ? DateTime.parse(groupStartDate) : nil
        end

        # Alias member count with fallback.
        #
        # @return [Integer, nil] the count of members of the Grom::Node or nil.
        def member_count
          respond_to?(:memberCount) ? memberCount.to_i : nil
        end

        # Alias groupEndDate with fallback.
        #
        # @return [DateTime, nil] the end date of the Grom::Node or nil.
        def end_date
          @end_date ||= respond_to?(:groupEndDate) ? DateTime.parse(groupEndDate) : nil
        end

        # @return [Boolean] whether the group is also a formal body.
        def formal_body?
          type.include?('https://id.parliament.uk/schema/FormalBody')
        end

        # Checks if Grom::Node has an end date.
        #
        # @return [Boolean] a boolean depending on whether or not the Grom::Node has an end date.
        def current?
          end_date.nil?
        end
      end
    end
  end
end
