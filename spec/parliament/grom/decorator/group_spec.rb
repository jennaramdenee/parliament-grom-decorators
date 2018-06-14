require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::Group, vcr: true do
  let(:response) { Parliament::Request::UrlRequest.new(
    base_url: 'http://localhost:3030/api/v1',
    builder: Parliament::Builder::NTripleResponseBuilder,
    decorators: Parliament::Grom::Decorator).group_by_id.get }
  let(:group_node) { response.filter('https://id.parliament.uk/schema/Group').first }

  describe '#member_count' do
    context 'Grom::Node has a members count' do
      it 'returns the members count for a Grom::Node object of type Group' do
        expect(group_node.member_count).to eq(13)
      end
    end

    context 'Grom::Node has no members count' do
      it 'returns the members count for a Grom::Node object of type Group' do
        expect(group_node.member_count).to eq(nil)
      end
    end
  end

  describe '#formal_body?' do
    context 'Grom::Node also has a type of FormalBody' do
      it 'returns true' do
        expect(group_node.formal_body?).to eq(true)
      end
    end

    context 'Grom::Node does not have a type of FormalBody' do
      it 'returns false' do
        expect(group_node.formal_body?).to eq(false)
      end
    end
  end
end
