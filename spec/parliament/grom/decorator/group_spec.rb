require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::Group, vcr: true do
  let(:response) { Parliament::Request::UrlRequest.new(
    base_url: 'http://localhost:3030/api/v1',
    builder: Parliament::Builder::NTripleResponseBuilder,
    decorators: Parliament::Grom::Decorator).group_by_id.get }
  let(:group_node) { response.filter('https://id.parliament.uk/schema/Group').first }

  describe '#name' do
    context 'Grom::Node has all the required objects' do
      it 'returns the name of the Grom::Node object' do
        expect(group_node.name).to eq('Artificial Intelligence Committee')
      end
    end

    context 'Grom::Node has none of the required objects' do
      it 'does not return the name for the this Grom::Node object' do
        expect(group_node.name).to eq('')
      end
    end
  end

  describe '#start_date' do
    context 'Grom::Node has all the required objects' do
      it 'returns the start_date of the Grom::Node object' do
        expect(group_node.start_date).to eq(DateTime.parse('Tue, 27 Jun 2017 00:00:00.000000000 +0000'))
      end
    end

    context 'Grom::Node does not have a start_date' do
      it 'confirms that start_date for this Grom::Node node does not exist' do
        expect(group_node.start_date).to eq(nil)
      end
    end
  end

  describe '#member_count' do
    context 'Grom::Node has a members count' do
        it 'returns the members count for a Grom::Node object of type Group' do
          expect(group_node.member_count).to eq(13)
        end
    end
  end

  describe '#end_date' do
    context 'Grom::Node has all the required objects' do
      it 'returns the end_date of the Grom::Node object' do
        expect(group_node.end_date).to eq(DateTime.parse('Tue, 27 Jun 2017 00:00:00.000000000 +0000'))
      end
    end

    context 'Grom::Node does not have a end_date' do
      it 'confirms that end_date for this Grom::Node node does not exist' do
        expect(group_node.end_date).to eq(nil)
      end
    end
  end
end
