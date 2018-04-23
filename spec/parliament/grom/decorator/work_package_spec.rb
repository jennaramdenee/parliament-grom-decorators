require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::WorkPackage, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).work_package_by_id.get
    @work_package = (response.filter('https://id.parliament.uk/schema/WorkPackage')).first
  end

  describe '#name' do
    context 'Grom::Node has a name' do
      it 'returns the name of the Grom::Node object' do
        expect(@work_package.name).to eq('An Example of an Affirmative SI Work Package')
      end
    end

    context 'Grom::Node does not have a name' do
      it 'returns an empty string' do
        expect(@work_package.name).to eq('')
      end
    end
  end

  describe '#procedures' do
    context 'Grom::Node has a set of procedures' do
      it 'returns an array of Grom::Nodes for the Grom::Node object' do
        expect(@work_package.procedures.size).to eq(1)
      end

      it 'returns an array of procedure Grom::Nodes for the Grom::Node object' do
        expect(@work_package.procedures.first.type).to eq('https://id.parliament.uk/schema/Procedure')
      end
    end

    context 'Grom::Node does not have any procedures' do
      it 'returns an empty array' do
        expect(@work_package.procedures).to eq([])
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
        expect(@work_package.actualised_steps.size).to eq(6)
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

  describe '#laid_date' do
    context 'Grom::Node has a laid date' do
      it 'returns a laid DateTime object for the Grom::Node object' do
        expect(@work_package.laid_date).to eq(DateTime.new(2018, 4, 18, 0, 0, 0))
      end
    end

    context 'Grom::Node does not have a laid date' do
      it 'returns an empty array' do
        expect(@work_package.laid_date).to eq(nil)
      end
    end
  end
end
