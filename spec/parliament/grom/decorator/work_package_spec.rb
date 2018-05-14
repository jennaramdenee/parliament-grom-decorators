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
      it 'returns an empty array' do
        expect(@work_package.procedure).to eq(nil)
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

  describe '#actualised_steps' do
    context 'Grom::Node has a set of actualised steps' do
      it 'returns an array of Grom::Nodes for the Grom::Node object' do
        expect(@work_package.actualised_steps.size).to eq(12)
      end

      it 'returns an array of ProcedureStep Grom::Nodes for the Grom::Node object' do
        expect(@work_package.actualised_steps.first.type).to eq('https://id.parliament.uk/schema/ProcedureStep')
      end
    end

    context 'Grom::Node does not have any actualised steps' do
      it 'returns an empty array' do
        expect(@work_package.actualised_steps).to eq([])
      end
    end
  end
end
