require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::StatutoryInstrument, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).work_package_by_id.get
    @statutory_instrument = (response.filter('https://id.parliament.uk/schema/StatutoryInstrument')).first
  end

  describe '#number_prefix' do
    context 'Grom::Node has a number prefix' do
      it 'returns the number prefix of the Grom::Node object' do
        expect(@statutory_instrument.number_prefix).to eq('SI')
      end
    end

    context 'Grom::Node does not have a number prefix' do
      it 'returns an empty string' do
        expect(@statutory_instrument.number_prefix).to eq('')
      end
    end
  end

  describe '#instrument_number' do
    context 'Grom::Node has an instrument number' do
      it 'returns the instrument number of the Grom::Node object' do
        expect(@statutory_instrument.instrument_number).to eq('899')
      end
    end

    context 'Grom::Node does not have an instrument number' do
      it 'returns an empty string' do
        expect(@statutory_instrument.instrument_number).to eq('')
      end
    end
  end

  describe '#number_year' do
    context 'Grom::Node has a number year' do
      it 'returns the number year of the Grom::Node object' do
        expect(@statutory_instrument.number_year).to eq('2018')
      end
    end

    context 'Grom::Node does not have a number year' do
      it 'returns an empty string' do
        expect(@statutory_instrument.number_year).to eq('')
      end
    end
  end

  describe '#citation' do
    context 'Grom::Node has all required data for a citation' do
      it 'returns the citation of the Grom::Node object' do
        expect(@statutory_instrument.citation).to eq('SI 2018/899')
      end
    end

    context 'Grom::Node does not have all required data for a citation' do
      context 'Grom::Node does not have a number prefix' do
        it 'returns an empty string' do
          expect(@statutory_instrument.citation).to eq('')
        end
      end

      context 'Grom::Node does not have a number year' do
        it 'returns an empty string' do
          expect(@statutory_instrument.citation).to eq('')
        end
      end

      context 'Grom::Node does not have an instrument number' do
        it 'returns an empty string' do
          expect(@statutory_instrument.citation).to eq('')
        end
      end
    end
  end

end
