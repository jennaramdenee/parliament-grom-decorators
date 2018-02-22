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
      it 'confirms that the type for this Grom::Node object is Collection' do
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

  describe '#articles' do
    context 'Grom::Node has all the required objects' do
      it 'returns an array of WebArticle Grom::Nodes' do
        expect(@collection.articles.first.type).to eq('https://id.parliament.uk/schema/WebArticle')
      end
    end

    context 'Grom::Node does not have articles' do
      it 'returns an empty array' do
        expect(@collection.articles).to eq([])
      end
    end
  end

  describe '#subcollections' do
    context 'Grom::Node has all the required objects' do
      it 'returns an array of Collection Grom::Nodes' do
        expect(@collection.subcollections.first.type).to eq('https://id.parliament.uk/schema/Collection')
      end
    end

    context 'Grom::Node does not have subcollections' do
      it 'returns an empty array' do
        expect(@collection.subcollections).to eq([])
      end
    end
  end

  describe '#parents' do
    context 'Grom::Node has all the required objects' do
      it 'returns an array of Collection Grom::Nodes' do
        expect(@collection.parents.first.type).to eq('https://id.parliament.uk/schema/Collection')
      end
    end

    context 'Grom::Node does not have parent collections' do
      it 'returns an empty array' do
        expect(@collection.parents).to eq([])
      end
    end
  end
end
