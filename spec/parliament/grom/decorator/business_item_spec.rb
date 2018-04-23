require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::BusinessItem, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).business_item_by_id.get
    @business_item = (response.filter('https://id.parliament.uk/schema/BusinessItem')).first
  end

  describe '#procedure_steps' do
    context 'Grom::Node has procedure steps' do
      it 'returns an array of Grom::Nodes' do
        expect(@business_item.procedure_steps.any?).to eq(true)
      end

      it 'returns an array of ProcedureStep Grom::Nodes' do
        expect(@business_item.procedure_steps.first.type).to eq('https://id.parliament.uk/schema/ProcedureStep')
      end
    end

    context 'Grom::Node has no procedure steps' do
      it 'returns an empty array' do
        expect(@business_item.procedure_steps).to eq([])
      end
    end
  end

  describe '#laying_date' do
    context 'Grom::Node has a laying date' do
      it 'returns a date' do
        expect(@business_item.laying_date).to eq(DateTime.new(2018, 4, 18, 0, 0, 0))
      end
    end

    context 'Grom::Node has no laying date' do
      it 'returns nil' do
        expect(@business_item.laying_date).to eq(nil)
      end
    end
  end
end
