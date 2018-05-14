require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::ProcedureStep, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).work_package_by_id.get
    @procedure_step = (response.filter('https://id.parliament.uk/schema/ProcedureStep')).first
  end

  describe '#name' do
    context 'Grom::Node has a name' do
      it 'returns the name of the Grom::Node object' do
        expect(@procedure_step.name).to eq('Consideration by the Joint Committee on Statutory Instruments')
      end
    end

    context 'Grom::Node does not have a name' do
      it 'returns an empty string' do
        expect(@procedure_step.name).to eq('')
      end
    end
  end

  describe '#colloquial_name' do
    context 'Grom::Node has a colloquial name' do
      it 'returns the common name of the Grom::Node object' do
        expect(@procedure_step.colloquial_name).to eq('Consideration by the JCSI')
      end
    end

    context 'Grom::Node does not have a colloquial name' do
      it 'returns an empty string' do
        expect(@procedure_step.colloquial_name).to eq('')
      end
    end
  end

  describe '#houses' do
    context 'Grom::Node has a house' do
      it 'returns an array of the Grom::Nodes' do
        expect(@procedure_step.houses.is_a?(Array)).to eq(true)
      end

      it 'returns an array of House Grom::Nodes' do
        expect(@procedure_step.houses.first.type).to eq('https://id.parliament.uk/schema/House')
      end
    end

    context 'Grom::Node does not have a house' do
      it 'returns an empty array' do
        expect(@procedure_step.houses).to eq([])
      end
    end
  end

  describe '#allows_routes' do
    context 'Grom::Node has a set of allowed routes' do
      it 'returns an array of the Grom::Nodes' do
        expect(@procedure_step.allows_routes.is_a?(Array)).to eq(true)
      end

      it 'returns an array of AllowedProcedureRoute Grom::Nodes' do
        expect(@procedure_step.allows_routes.first.type).to include('https://id.parliament.uk/schema/AllowedProcedureRoute')
      end
    end

    context 'Grom::Node does not have allowed routes' do
      it 'returns an empty array' do
        expect(@procedure_step.allows_routes).to eq([])
      end
    end
  end

  describe '#causes_routes' do
    context 'Grom::Node has a set of causes routes' do
      it 'returns an array of the Grom::Nodes' do
        expect(@procedure_step.causes_routes.is_a?(Array)).to eq(true)
      end

      it 'returns an array of CausedProcedureRoute Grom::Nodes' do
        expect(@procedure_step.causes_routes.first.type).to include('https://id.parliament.uk/schema/CausedProcedureRoute')
      end
    end

    context 'Grom::Node does not have causes routes' do
      it 'returns an empty array' do
        expect(@procedure_step.causes_routes).to eq([])
      end
    end
  end

  describe '#potential_next_steps' do
    context 'Grom::Node has a set of potential next steps' do
      it 'returns an array of the Grom::Nodes' do
        expect(@procedure_step.potential_next_steps.is_a?(Array)).to eq(true)
      end

      it 'returns an array of ProcedureStep Grom::Nodes' do
        expect(@procedure_step.potential_next_steps.first.type).to include('https://id.parliament.uk/schema/ProcedureStep')
      end
    end

    context 'Grom::Node does not have causes routes' do
      it 'returns an empty array' do
        expect(@procedure_step.potential_next_steps).to eq([])
      end
    end
  end
end
