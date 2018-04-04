require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::Collection, vcr: true do
  before(:each) do
    id = 'asdf1234'
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).collection_by_id.get
    @collection = (response.filter('https://id.parliament.uk/schema/Collection')).first
  end

  describe '#name' do
    context 'Grom::Node has all the required objects' do
      it 'confirms that the type for this Grom::Node object is Collection' do
        expect(@collection.type).to eq('https://id.parliament.uk/schema/Collection')
      end

      it 'returns the name of the Grom::Node object' do
        expect(@collection.name).to eq('Questions')
      end
    end

    context 'Grom::Node does not have a name' do
      it 'returns an empty string' do
        expect(@collection.name).to eq('')
      end
    end
  end

  describe '#description' do
    context 'Grom::Node has all the required objects' do
      it 'returns the description of the Grom::Node object' do
        expect(@collection.description).to eq('You can ask a Minister an oral question in person or a written question. Questions are submitted via the Table Office.')
      end
    end

    context 'Grom::Node does not have a description' do
      it 'returns an empty string' do
        expect(@collection.description).to eq('')
      end
    end
  end

  describe '#extendedDescription' do
    context 'Grom::Node has all the required objects' do
      it 'returns the extended description of the Grom::Node object' do
        expect(@collection.extended_description).to eq('You can ask a Minister an oral question in person or a written question. Questions are submitted via the Table Office.')
      end
    end

    context 'Grom::Node does not have an extended description' do
      it 'returns an empty string' do
        expect(@collection.extended_description).to eq('')
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

  describe '#collections_paths' do
    context 'Grom::Node has all the required objects' do
      it 'returns an array of arrays of Collection Grom::Nodes' do
        expect(@collection.collections_paths.first.first.type).to eq('https://id.parliament.uk/schema/Collection')
      end
    end

    context 'Grom::Node does not have any collection paths' do
      it 'returns an empty array' do
        expect(@collection.collections_paths).to eq([])
      end
    end
  end
end
