module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/Person.
      module Person
        include Helpers::DateHelper

        # Alias personGivenName with fallback.
        #
        # @return [String, String] the given name of the Grom::Node or an empty string.
        def given_name
          respond_to?(:personGivenName) ? personGivenName : ''
        end

        # Alias personFamilyName with fallback.
        #
        # @return [String, String] the family name of the Grom::Node or an empty string.
        def family_name
          respond_to?(:personFamilyName) ? personFamilyName : ''
        end

        # Alias personOtherNames with fallback.
        #
        # @return [String, String] the other names of the Grom::Node or an empty string.
        def other_name
          respond_to?(:personOtherNames) ? personOtherNames : ''
        end

        # Alias personDateOfBirth with fallback.
        #
        # @return [DateTime, nil] the date of birth of the Grom::Node or nil.
        def date_of_birth
          @date_of_birth ||= respond_to?(:personDateOfBirth) ? DateTime.parse(personDateOfBirth) : nil
        end

        # Builds a full name using personGivenName and personFamilyName.
        #
        # @return [String, String] the full name of the Grom::Node or an empty string.
        def full_name
          return @full_name unless @full_name.nil?

          full_name = []
          full_name << personGivenName if respond_to?(:personGivenName)
          full_name << personFamilyName if respond_to?(:personFamilyName)

          @full_name = full_name.join(' ')
        end

        # Alias personHasPersonImage with fallback.
        #
        # @return [String, String] the image location of the Grom::Node or a placeholder string.
        def image_id(show_placeholder: true)
          if respond_to?(:memberHasMemberImage)
            memberHasMemberImage.first.graph_id
          else
            show_placeholder ? 'placeholder' : nil
          end
        end

        # Alias personPimsId with fallback.
        #
        # @return [Array, Array] the pims_id of the Grom::Node or nil.
        def pims_id
          respond_to?(:personPimsId) ? personPimsId : nil
        end

        # Alias memberMnisId with fallback.
        #
        # @return [Array, Array] the mnis_id of the Grom::Node or nil.
        def mnis_id
          respond_to?(:memberMnisId) ? memberMnisId : nil
        end

        # Alias memberHasParliamentaryIncumbency with fallback.
        #
        # @return [Array, Array] all the incumbencies of the Grom::Node or an empty array.
        def incumbencies
          respond_to?(:memberHasParliamentaryIncumbency) ? memberHasParliamentaryIncumbency : []
        end

        # Alias memberHasParliamentaryIncumbency with fallback.
        #
        # @return [Array, Array] the seat incumbencies of the Grom::Node or an empty array.
        def seat_incumbencies
          @seat_incumbencies ||= incumbencies.select { |inc| inc.type == 'https://id.parliament.uk/schema/SeatIncumbency' }
        end

        # @return [Grom::Node] the seat incumbency as a Grom::Node or nil
        def current_seat_incumbency
          @current_seat_incumbency ||= seat_incumbencies.select(&:current?)&.first
        end

        # @return [Grom::Node] the most recent seat incumbency as a Grom::Node or nil
        def most_recent_seat_incumbency
          @most_recent_seat_incumbency ||= seat_incumbencies.sort_by!(&:start_date).reverse.first
        end

        # Alias seatIncumbencyHasHouseSeat with fallback.
        #
        # @return [Array, Array] the seats of the Grom::Node or an empty array.
        def seats
          @seats ||= seat_incumbencies.map(&:seat).flatten.uniq.compact
        end

        # Alias houseSeatHasHouse with fallback.
        #
        # @return [Array, Array] the houses of the Grom::Node or an empty array.
        def houses
          @houses ||= [seats.map(&:house), seat_incumbencies.map(&:house)].flatten.uniq.compact
        end

        # Alias houseSeatHasConstituencyGroup with fallback.
        #
        # @return [Array, Array] the constituencies of the Grom::Node or an empty array.
        def constituencies
          @constituencies ||= seats.map(&:constituency).flatten.uniq.compact
        end

        # Alias partyMemberHasPartyMembership with fallback.
        #
        # @return [Array, Array] the party memberships of the Grom::Node or an empty array.
        def party_memberships
          respond_to?(:partyMemberHasPartyMembership) ? partyMemberHasPartyMembership : []
        end

        # Alias partyMembershipHasParty with fallback.
        #
        # @return [Array, Array] the parties of the Grom::Node or an empty array.
        def parties
          @parties ||= party_memberships.map(&:party).flatten.uniq.compact
        end

        # Alias partyMembershipHasParty with fallback.
        #
        # @return [Grom::Node] the current party of the Grom::Node or nil.
        def current_party
          @current_party ||= party_memberships.select(&:current?).select(&:party)&.first&.party
        end

        # Alias partyMembershipHasParty with fallback.
        #
        # @return [Grom::Node] the current party membership of the Grom::Node or nil.
        def current_party_membership
          @current_party_membership ||= party_memberships.select(&:current?).select(&:party)&.first
        end

        # Alias personHasContactPoint with fallback.
        #
        # @return [Array, Array] the contact points of the Grom::Node or an empty array.
        def contact_points
          respond_to?(:personHasContactPoint) ? personHasContactPoint : []
        end

        # Alias personHasGenderIdentity with fallback.
        #
        # @return [Array, Array] the gender identities of the Grom::Node or an empty array.
        def gender_identities
          respond_to?(:personHasGenderIdentity) ? personHasGenderIdentity : []
        end

        # Alias genderIdentityHasGender with fallback.
        #
        # @return [Array, Array] the gender of the Grom::Node or nil.
        def gender
          gender_identities.empty? ? nil : gender_identities.first.gender
        end

        # Checks the statuses of the Grom::Node.
        #
        # @return [Hash, Hash] the statuses of the Grom::Node or an empty hash.
        def statuses
          return @statuses unless @statuses.nil?

          statuses = {}
          statuses[:house_membership_status] = house_membership_status
          statuses[:general_membership_status] = general_membership_status

          @statuses = statuses
        end

        # Check whether they have a current seat on the House of Commons.
        #
        # @return [Boolean] a boolean depending on whether or not they have a current seat incumbency in the House of Commons.
        def current_mp?
          current_member_by_house?('House of Commons')
        end

        # Check whether they are a former member of the House of Commons.
        #
        # @return [Boolean] a boolean depending on whether or not they have a current seat incumbency in the House of Commons.
        def former_mp?
          former_member_by_house?('House of Commons')
        end

        # Check whether they have a current seat on the House of Lords.
        #
        # @return [Boolean] a boolean depending on whether or not they have a current seat incumbency in the House of Lords.
        def current_lord?
          current_member_by_house?('House of Lords')
        end

        # Check whether member is an ex_officio?.
        #
        # @return [Boolean] a boolean depending on whether or not member is an ex_officio?
        def ex_officio?
          respond_to?(:memberHasExOfficioMembership)
        end

        # Check whether member is an alternate?.
        #
        # @return [Boolean] a boolean depending on whether or not member is an alternate?
        def alternate?
          respond_to?(:memberHasAlternateMembership)
        end

        # Check whether person is a lay member?.
        #
        # @return [Boolean] a boolean depending on whether or person is a lay member or not
        def lay_member?
          respond_to?(:formalBodyLayPersonMnisId)
        end

        # Check whether they are a former member of the House of Lords.
        #
        # @return [Boolean] a boolean depending on whether or not they have a current seat incumbency in the House of Lords.
        def former_lord?
          former_member_by_house?('House of Lords')
        end

        # Check whether they are a Member or a Lord from their latest seat incumbency.
        # Current incumbencies are higher priority when determining a person_type
        # Therefore check first for former, then current
        # @return [String] 'member' if they are a member, 'lord' if they are a lord.
        def person_type
          person_type = 'member' if former_mp?
          person_type = 'lord' if former_lord?
          person_type = 'member' if current_mp?
          person_type = 'lord' if current_lord?
          person_type
        end

        # Alias D79B0BAC513C4A9A87C9D5AFF1FC632F with fallback.
        #
        # @return [String, String] the full title of the Grom::Node or an empty string.
        def full_title
          respond_to?(:D79B0BAC513C4A9A87C9D5AFF1FC632F) ? self.D79B0BAC513C4A9A87C9D5AFF1FC632F : ''
        end

        # Alias F31CBD81AD8343898B49DC65743F0BDF with fallback.
        #
        # @return [String, String] the display name of the Grom::Node or the full name.
        def display_name
          respond_to?(:F31CBD81AD8343898B49DC65743F0BDF) ? self.F31CBD81AD8343898B49DC65743F0BDF : full_name
        end

        # Alias A5EE13ABE03C4D3A8F1A274F57097B6C with fallback.
        #
        # @return [String, String] the sort name of the Grom::Node or an empty string.
        def sort_name
          respond_to?(:A5EE13ABE03C4D3A8F1A274F57097B6C) ? self.A5EE13ABE03C4D3A8F1A274F57097B6C : ''
        end

        # Alias memberHasFormalBodyMembership with fallback.
        #
        # @return [Array, Array] all the formal body memberships of the Grom::Node or an empty array.
        def formal_body_memberships
          respond_to?(:memberHasFormalBodyMembership) ? memberHasFormalBodyMembership : []
        end

        # Alias governmentIncumbency with fallback.
        #
        # @return [Array, Array] all the government incumbencies of the Grom::Node or an empty array.
        def government_incumbencies
          respond_to?(:governmentPersonHasGovernmentIncumbency) ? governmentPersonHasGovernmentIncumbency : []
        end

        # Alias personHasPersonalWebLink with fallback.
        #
        # @return [Array, Array] all the personal weblinks of the Grom::Node or an empty Array.
        def personal_weblinks
          [*get_weblinks_by_predicate(:personHasPersonalWebLink)]
        end

        # Alias personHasTwitterWebLink with fallback.
        #
        # @return [Array, Array] all the Twitter weblinks of the Grom::Node or an empty array.
        def twitter_weblinks
          [*get_weblinks_by_predicate(:personHasTwitterWebLink)]
        end

        # Alias personHasFacebookWebLink with fallback.
        #
        # @return [Array, Array] all the Facebook weblinks of the Grom::Node or an empty array.
        def facebook_weblinks
          [*get_weblinks_by_predicate(:personHasFacebookWebLink)]
        end

        # Check whether a person has any weblinks
        def weblinks?
          (personal_weblinks + twitter_weblinks + facebook_weblinks).any?
        end

        private

        def current_member_by_house?(house_name)
          incumbencies.select { |incumbency| incumbency.house.name == house_name && incumbency.end_date.nil? }.any?
        end

        def former_member_by_house?(house_name)
          incumbencies.select { |incumbency| incumbency.house.name == house_name && incumbency.end_date }.any?
        end

        def house_membership_status
          statuses     = []
          current_mp   = current_mp?
          current_lord = current_lord?
          statuses << I18n.t('person.current.mp') if current_mp
          statuses << I18n.t('person.current.member_of_the_house_of_lords') if current_lord
          statuses << I18n.t('person.former.member_of_the_house_of_lords') if former_lord? && !current_lord
          statuses << I18n.t('person.former.mp') if former_mp? && !current_mp

          convert_house_membership_status(statuses)
        end

        def general_membership_status
          statuses = []
          statuses << I18n.t('person.current.member') unless incumbencies.select(&:current?).empty?
          statuses << I18n.t('person.former.member') if incumbencies.any? && incumbencies.select(&:current?).empty?
          statuses
        end

        def convert_house_membership_status(statuses)
          statuses.each_with_index do |status, index|
            status[0] = status[0].downcase if index != 0
          end
        end

        def get_weblinks_by_predicate(weblink_predicate)
          (respond_to?(weblink_predicate) && (current_mp? || current_lord?) ? send(weblink_predicate) : nil)
        end
      end
    end
  end
end
