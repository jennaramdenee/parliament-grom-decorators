module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/FormalBody.
      module FormalBody
        include Helpers::DateHelper

        # Checks if Grom::Node has a name.
        #
        # @return [String, String] a string depending on whether or not the Grom::Node has a name.
        def name
          @name ||= respond_to?(:formalBodyName) ? formalBodyName : ''
        end

        # Checks if Grom::Node has a chair.
        #
        # @return [Boolean] a boolean depending on whether or not the Grom::Node is chair.
        def has_chair?
          respond_to?(:formalBodyHasFormalBodyChair)
        end

        # Alias is_chair with fallback.
        #
        # @return [Array, Array] an array of Position Grom::Nodes representing the chair or an empty array.
        def chairs
          respond_to?(:formalBodyHasFormalBodyChair) ? formalBodyHasFormalBodyChair : []
        end

        # @return [Array, Array] array of Person Grom::Node(s) representing the current incumbent(s) of chair position(s).
        def chair_people
          chairs.first&.incumbencies&.first&.people || []
        end

        # Alias formalBodyStartDate with fallback.
        #
        # @return [DateTime, nil] the start date of the Grom::Node or nil.
        def start_date
          @start_date ||= respond_to?(:formalBodyStartDate) ? DateTime.parse(formalBodyStartDate) : nil
        end

        # Checks if Grom::Node has a remit.
        #
        # @return [String, String] a string depending on whether or not the Grom::Node has a remit.
        def remit
          @remit ||= respond_to?(:formalBodyRemit) ? formalBodyRemit : ''
        end

        # Checks if Grom::Node is joint.
        #
        # @return [Boolean] a boolean depending on whether or not the Grom::Node is joint.
        def joint?
          respond_to?(:formalBodyHasLeadHouse)
        end

        # Alias formalBodyEndDate with fallback.
        #
        # @return [DateTime, nil] the end date of the Grom::Node or nil.
        def end_date
          @end_date ||= respond_to?(:formalBodyEndDate) ? DateTime.parse(formalBodyEndDate) : nil
        end

        # Checks if Grom::Node has an end date.
        #
        # @return [Boolean] a boolean depending on whether or not the Grom::Node has an end date.
        def current?
          end_date.nil?
        end

        # Checks if Grom::Node has contact points.
        #
        # @return [Array, Array] an array containing the contact_point(s), or an empty array.
        def contact_points
          @contact_points ||= respond_to?(:formalBodyHasContactPoint) ? Array(formalBodyHasContactPoint) : []
        end

        # Checks if Grom::Node has a house.
        #
        # @return [Array, Array] an array of House Grom::Nodes, or an empty array.
        def houses
          respond_to?(:formalBodyHasHouse) ? formalBodyHasHouse : []
        end

        # Checks if the type of Grom::Node is a select committee.
        #
        # @return [Boolean] whether or not the group is a select committee.
        def select_committee?
          type.include?('https://id.parliament.uk/schema/SelectCommittee')
        end

        # Checks what type of committee a Grom::Node represents.
        # TODO: Build out as the types of possible committee types grows
        #
        # @return [String, String] whether or not the group is a select committee.
        def committee_type
         select_committee? ? 'select' : ''
        end
      end
    end
  end
end
