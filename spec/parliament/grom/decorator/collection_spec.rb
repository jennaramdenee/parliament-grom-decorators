require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::Collection, vcr: true do
  before(:each) do
    id = 'asdf1234'
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).collection_by_id.get
    @collection = (response.filter('http://example.com/content/Collection')).first
  end

  describe '#collection_name' do
    context 'Grom::Node has all the required objects' do
      it 'confirms that the type for this Grom::Node object is Article' do
        expect(@collection.type).to eq('http://example.com/content/Collection')
      end

      it 'returns the title of the article the Grom::Node object' do
        expect(@collection.collection_name).to eq('collection 1')
      end
    end

    context 'Grom::Node does not have a title' do
      it 'returns an empty string' do
        expect(@collection.collection_name).to eq('')
      end
    end
  end

  describe '#collection_description' do
    context 'Grom::Node has all the required objects' do
      it 'returns the title of the article the Grom::Node object' do
        expect(@collection.collection_description).to eq('You can ask a Minister an oral question in person or a written question. Questions are submitted via the Table Office.')
      end
    end

    context 'Grom::Node does not have a title' do
      it 'returns an empty string' do
        expect(@collection.collection_description).to eq('')
      end
    end
  end
end
