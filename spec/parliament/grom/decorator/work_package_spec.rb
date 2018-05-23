require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::WorkPackage, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).work_package_by_id.get
    @work_package = (response.filter('https://id.parliament.uk/schema/WorkPackage')).first
  end

  describe '#procedure' do
    context 'Grom::Node has a procedure' do
      it 'returns an array of procedure Grom::Nodes for the Grom::Node object' do
        expect(@work_package.procedure.type).to eq('https://id.parliament.uk/schema/Procedure')
      end
    end

    context 'Grom::Node does not have a procedure' do
      it 'returns nil' do
        expect(@work_package.procedure).to eq(nil)
      end
    end
  end

  describe '#work_packageable_thing' do
    context 'Grom::Node has a work packageable thing' do
      it 'returns an array of procedure Grom::Nodes for the Grom::Node object' do
        expect(@work_package.work_packageable_thing.type).to include('https://id.parliament.uk/schema/WorkPackageableThing')
      end
    end

    context 'Grom::Node does not have a work packageable thing' do
      it 'returns nil' do
        expect(@work_package.work_packageable_thing).to eq(nil)
      end
    end
  end

  describe '#business_items' do
    context 'Grom::Node has a set of business items' do
      it 'returns an array of Grom::Nodes for the Grom::Node object' do
        expect(@work_package.business_items.size).to eq(6)
      end

      it 'returns an array of business item Grom::Nodes for the Grom::Node object' do
        expect(@work_package.business_items.first.type).to include('https://id.parliament.uk/schema/BusinessItem')
      end
    end

    context 'Grom::Node does not have any business items' do
      it 'returns an empty array' do
        expect(@work_package.business_items).to eq([])
      end
    end
  end

  describe '#oldest_business_item' do
    context 'Grom::Node has an oldest business item' do
      it 'returns a business item Grom::Node' do
        expect(@work_package.oldest_business_item.type).to include('https://id.parliament.uk/schema/BusinessItem')
      end
    end

    context 'Grom::Node does not have an oldest business item' do
      it 'returns nil' do
        expect(@work_package.oldest_business_item).to eq(nil)
      end
    end
  end

  describe '#oldest_business_item_date' do
    context 'Grom::Node has an oldest business item date' do
      it 'returns a date' do
        expect(@work_package.oldest_business_item_date).to eq(DateTime.new(2018,04,30,0,0,0))
      end
    end

    context 'Grom::Node has an oldest business item with no date' do
      it 'returns nil' do
        expect(@work_package.oldest_business_item_date).to eq(nil)
      end
    end

    context 'Grom::Node does not have any business items' do
      it 'returns nil' do
        expect(@work_package.oldest_business_item_date).to eq(nil)
      end
    end
  end

end
