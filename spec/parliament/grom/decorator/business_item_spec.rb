require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::BusinessItem, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).work_package_by_id.get
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

  describe '#date' do
    context 'Grom::Node has a date' do
      it 'returns a date' do
        expect(@business_item.date).to eq(DateTime.new(2017, 11, 15, 0, 0, 0))
      end
    end

    context 'Grom::Node has no date' do
      it 'returns nil' do
        expect(@business_item.date).to eq(nil)
      end
    end
  end

  describe '#web_link' do
    context 'Grom::Node has a web link' do
      it 'returns a web link' do
        expect(@business_item.web_link).to eq('https://publications.parliament.uk/pa/jt201719/jtselect/jtstatin/40/4002.htm')
      end
    end

    context 'Grom::Node has no web link' do
      it 'returns an empty string' do
        expect(@business_item.web_link).to eq('')
      end
    end
  end

  describe '#laying_body' do
    context 'Grom::Node has a laying body' do
      it 'returns a Grom::Node representing the laying body' do
        expect(@business_item.laying_body.type).to include('https://id.parliament.uk/schema/Group')
      end
    end

    context 'Grom::Node has no laying date' do
      it 'returns nil' do
        expect(@business_item.laying_body).to eq(nil)
      end
    end
  end

  describe '#procedure_steps_houses' do
    context 'Grom::Node has a set of procedure step houses' do
      it 'returns an array of Grom::Nodes representing procedure step houses' do
        expect(@business_item.procedure_steps_houses.first.type).to include('https://id.parliament.uk/schema/House')
      end
    end

    context 'Grom::Node has no procedure step houses' do
      it 'returns an empty array' do
        expect(@business_item.procedure_steps_houses).to eq([])
      end
    end
  end

  describe '#procedure_steps_house_names' do
    context 'Grom::Node has a set of procedure step house names' do
      it 'returns an array of Grom::Nodes representing procedure step houses' do
        expect(@business_item.procedure_steps_house_names).to eq('House of Commons and House of Lords')
      end
    end

    context 'Grom::Node has no procedure step house names' do
      it 'returns an empty string' do
        expect(@business_item.procedure_steps_house_names).to eq('')
      end
    end
  end
end
