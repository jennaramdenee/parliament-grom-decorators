require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::Procedure, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).work_package_by_id.get
    @procedure = (response.filter('https://id.parliament.uk/schema/Procedure')).first
  end

  describe '#name' do
    context 'Grom::Node has a name' do
      it 'returns the name of the Grom::Node object' do
        expect(@procedure.name).to eq('Made Affirmative')
      end
    end

    context 'Grom::Node does not have a name' do
      it 'returns an empty string' do
        expect(@procedure.name).to eq('')
      end
    end
  end

  describe '#made_affirmative' do
    context "Grom::Node has a procedure name of 'Made Affirmative'" do
      xit 'returns true' do
        expect(@procedure.made_affirmative?).to eq(true)
      end
    end

    context "Grom::Node does not have a procedure name of 'Made Affirmative'" do
      xit 'returns false' do
        expect(@procedure.made_affirmative?).to eq(false)
      end
    end
  end
end
