require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::ProcedureRoute, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).work_package_by_id.get
    @procedure_route = (response.filter('https://id.parliament.uk/schema/ProcedureRoute')).first
  end

  describe '#steps' do
    context 'Grom::Node has steps' do
      it 'returns an array of Grom::Nodes' do
        expect(@procedure_route.steps.is_a?(Array)).to eq(true)
      end

      it 'returns an array of ProcedureStep Grom::Nodes' do
        expect(@procedure_route.steps.first.type).to include('https://id.parliament.uk/schema/ProcedureStep')
      end
    end

    context 'Grom::Node does not have steps' do
      it 'returns an empty array' do
        expect(@procedure_route.steps).to eq([])
      end
    end
  end
end
