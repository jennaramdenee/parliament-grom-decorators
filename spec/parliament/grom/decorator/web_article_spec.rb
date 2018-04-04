require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::WebArticle, vcr: true do
  before(:each) do
    id = 'asdf1234'
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).webarticle_by_id.get
    @article = (response.filter('https://id.parliament.uk/schema/WebArticle')).first
  end

  describe '#article_title' do
    context 'Grom::Node has all the required objects' do
      it 'confirms that the type for this Grom::Node object is Article' do
        expect(@article.type).to eq('https://id.parliament.uk/schema/WebArticle')
      end

      it 'returns the title of the article the Grom::Node object' do
        expect(@article.article_title).to eq('First Article')
      end
    end

    context 'Grom::Node does not have a title' do
      it 'returns an empty string' do
        expect(@article.article_title).to eq('')
      end
    end
  end

  describe '#article_summary' do
    context 'Grom::Node has all the required objects' do
      it 'returns the summary of the article the Grom::Node object' do
        expect(@article.article_summary).to include('Lorem ipsum.')
      end
    end

    context 'Grom::Node does not have a summary' do
      it 'returns an empty string' do
        expect(@article.article_summary).to eq('')
      end
    end
  end

  describe '#article_body' do
    context 'Grom::Node has all the required objects' do
      it 'returns the body of the article the Grom::Node object' do
        expect(@article.article_body).to include('Some body.')
      end
    end

    context 'Grom::Node does not have a body' do
      it 'returns an empty string' do
        expect(@article.article_body).to eq('')
      end
    end
  end

  describe '#collections' do
    context 'Grom::Node has all the required objects' do
      it 'returns an array' do
        expect(@article.collections).to be_a(Array)
      end

      it 'returns an array of Grom Nodes' do
        expect(@article.collections[0]).to be_a(Grom::Node)
      end
    end

    context 'Grom::Node does not have any collections' do
      it 'returns an empty array' do
        expect(@article.collections).to eq([])
      end
    end
  end

  describe '#types' do
    context 'Grom::Node has all the required objects' do
      it 'returns an array' do
        expect(@article.types).to be_a(Array)
      end

      it 'returns an array of Grom Nodes' do
        expect(@article.types[0]).to be_a(Grom::Node)
      end
    end

    context 'Grom::Node does not have any article types' do
      it 'returns an empty array' do
        expect(@article.types).to eq([])
      end
    end
  end

  describe '#audiences' do
    context 'Grom::Node has all the required objects' do
      it 'returns an array' do
        expect(@article.audiences).to be_a(Array)
      end

      it 'returns an array of Grom Nodes' do
        expect(@article.audiences[0]).to be_a(Grom::Node)
      end
    end

    context 'Grom::Node does not have any article types' do
      it 'returns an empty array' do
        expect(@article.audiences).to eq([])
      end
    end
  end

  describe '#topics' do
    context 'Grom::Node has all the required objects' do
      it 'returns an array' do
        expect(@article.topics).to be_a(Array)
      end

      it 'returns an array of Grom Nodes' do
        expect(@article.topics[0]).to be_a(Grom::Node)
      end
    end

    context 'Grom::Node does not have any article types' do
      it 'returns an empty array' do
        expect(@article.topics).to eq([])
      end
    end
  end

  describe '#publishers' do
    context 'Grom::Node has all the required objects' do
      it 'returns an array' do
        expect(@article.publishers).to be_a(Array)
      end

      it 'returns an array of Grom Nodes' do
        expect(@article.publishers[0]).to be_a(Grom::Node)
      end
    end

    context 'Grom::Node does not have any article types' do
      it 'returns an empty array' do
        expect(@article.publishers).to eq([])
      end
    end
  end

  describe '#related_articles' do
    context 'Grom::Node has all the required objects' do
      it 'returns an array' do
        expect(@article.related_articles).to be_a(Array)
      end

      it 'returns an array of Grom Nodes' do
        expect(@article.related_articles[0]).to be_a(Grom::Node)
      end
    end

    context 'Grom::Node does not have any related articles' do
      it 'returns an empty array' do
        expect(@article.related_articles).to eq([])
      end
    end
  end

  describe '#collections_paths' do
    context 'Grom::Node has all the required objects' do
      it 'returns an array of arrays of Collection Grom::Nodes' do
        expect(@article.collections_paths.first.first.type).to eq('https://id.parliament.uk/schema/Collection')
      end
    end

    context 'Grom::Node does not have any collection paths' do
      it 'returns an empty array' do
        expect(@article.collections_paths).to eq([])
      end
    end
  end
end
