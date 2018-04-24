require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::FormalBody, vcr: true do
  let(:response) { Parliament::Request::UrlRequest.new(
    base_url: 'http://localhost:3030/api/v1',
    builder: Parliament::Builder::NTripleResponseBuilder,
    decorators: Parliament::Grom::Decorator).group_by_id.get }
  let(:formal_body_node) { response.filter('https://id.parliament.uk/schema/FormalBody').first }

  context '#name' do
    context 'Grom::Node has a name' do
      it 'will return correct name' do
        expect(formal_body_node.name).to eq('Artificial Intelligence Committee')
      end
    end

    context 'Grom::Node has no name' do
      it 'will return an empty string' do
        expect(formal_body_node.name).to eq('')
      end
    end
  end

  context '#has_chair?' do
    context 'has a committee chair' do
      it 'will return true' do
        expect(formal_body_node.has_chair?).to eq(true)
      end
    end

    context 'does not have a committee chair' do
      it 'will return false' do
        expect(formal_body_node.has_chair?).to eq(false)
      end
    end
  end

  context '#chairs' do
    context 'has a committee chair' do
      it 'will return an array of Grom::Nodes' do
        expect(formal_body_node.chairs.first.class).to eq(Grom::Node)
      end

      it 'will return an array of Position Grom::Nodes' do
        expect(formal_body_node.chairs.first.type).to eq('https://id.parliament.uk/schema/Position')
      end
    end

    context 'does not have a committee chair' do
      it 'will return an empty array' do
        expect(formal_body_node.chairs).to eq([])
      end
    end
  end

  context '#chair_people' do
    context 'has a committee chair person' do
      it 'will return an array of Grom::Nodes' do
        expect(formal_body_node.chair_people.first.class).to eq(Grom::Node)
      end

      it 'will a Person Grom::Node' do
        expect(formal_body_node.chair_people.first.type).to eq('https://id.parliament.uk/schema/Person')
      end
    end

    context 'does not have a committee chair person' do
      it 'will return an empty array' do
        expect(formal_body_node.chair_people).to eq([])
      end
    end
  end

  context '#start_date' do
    context 'Grom::Node has a start date' do
      it 'will return correct start date' do
        expect(formal_body_node.start_date).to eq(DateTime.parse('2017-06-27T00:00:00+00:00'))
        expect(formal_body_node.start_date.class).to eq(DateTime)
      end
    end

    context 'Grom::Node has no start date' do
      it 'will return nil' do
        expect(formal_body_node.start_date).to eq(nil)
      end
    end
  end

  context '#remit' do
    context 'Grom::Node has a description' do
      it 'will return correct remit' do
        expect(formal_body_node.remit).to eq('We evaluate the economic, ethical and social impacts of advances in artificial intelligence.')
      end
    end

    context 'Grom::Node has no description' do
      it 'will return an empty string' do
        expect(formal_body_node.remit).to eq('')
      end
    end
  end

  context '#joint?' do
    context 'is a joint committee' do
      it 'will return true' do
        expect(formal_body_node.joint?).to eq(true)
      end
    end

    context 'is not a joint committee' do
      it 'will return false' do
        expect(formal_body_node.joint?).to eq(false)
      end
    end
   end

  context '#end_date' do
    context 'Grom::Node has an end date' do
      it 'will return correct end date' do
        expect(formal_body_node.end_date).to eq(DateTime.parse('2019-06-27T00:00:00+00:00'))
        expect(formal_body_node.end_date.class).to eq(DateTime)
      end
    end

    context 'Grom::Node has no end date' do
      it 'will return nil' do
        expect(formal_body_node.end_date).to eq(nil)
      end
    end
  end

  context '#current?' do
    context 'is current' do
      it 'will return true' do
        expect(formal_body_node.current?).to eq(true)
      end
    end

    context 'is not current' do
      it 'will return false' do
        expect(formal_body_node.current?).to eq(false)
      end
    end
  end

  context '#contact_point' do
    context 'formal body has a contact point' do
      it 'return the contact point' do
        expect(formal_body_node.contact_points.first.email).to eq('HLAIAdHoc@parliament.uk')
      end
    end

    context 'formal body does not have a contact point' do
      it 'returns an empty array' do
        expect(formal_body_node.contact_points).to eq([])
      end
    end
  end

  context '#houses' do
    context 'has at least one house' do
      it 'will return a Grom::Node' do
        expect(formal_body_node.houses.first.class).to eq(Grom::Node)
      end

      it 'will return a House Grom::Node' do
        expect(formal_body_node.houses.first.type).to eq('https://id.parliament.uk/schema/House')
      end
    end

    context 'does not have a house' do
      it 'will return an empty array' do
        expect(formal_body_node.houses).to eq([])
      end
    end
  end

  context '#select_committee?' do
    context 'Grom::Node has a type of select committee' do
      it 'will return true' do
        expect(formal_body_node.select_committee?).to eq(true)
      end
    end

    context 'Grom::Node has no type of select committee' do
      it 'will return false' do
        expect(formal_body_node.select_committee?).to eq(false)
      end
    end
  end

  context '#committee_type' do
    context 'Grom::Node has a type of select committee' do
      it 'will return select' do
        expect(formal_body_node.committee_type).to eq('select')
      end
    end

    context 'Grom::Node has no type of select committee' do
      it 'will return an empty string' do
        expect(formal_body_node.committee_type).to eq('')
      end
    end
  end
end
