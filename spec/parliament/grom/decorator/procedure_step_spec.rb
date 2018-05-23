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

  describe '#distance_from_origin' do
    context 'Grom::Node has a distance from origin' do
      it 'returns the distance as an integer' do
        expect(@procedure_step.distance_from_origin).to eq(3)
      end
    end

    context 'Grom::Node does not have any work packages' do
      it 'returns zero' do
        expect(@procedure_step.distance_from_origin).to eq(0)
      end
    end
  end

  describe '#business_item' do
    context 'Grom::Node has a business item' do
      it 'returns a BusinessItem Grom::Node' do
        expect(@procedure_step.business_item.type).to eq('https://id.parliament.uk/schema/BusinessItem')
      end
    end

    context 'Grom::Node does not have a business item' do
      it 'returns nil' do
        expect(@procedure_step.business_item).to eq(nil)
      end
    end
  end


end
