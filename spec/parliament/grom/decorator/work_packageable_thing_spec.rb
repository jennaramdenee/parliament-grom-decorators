require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::WorkPackageableThing, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).work_packageable_thing_by_id.get
    @work_packageble_thing = (response.filter('https://id.parliament.uk/schema/WorkPackageableThing')).first
  end

  describe '#name' do
    context 'Grom::Node has a name' do
      it 'returns the name of the Grom::Node object' do
        expect(@work_packageble_thing.name).to eq('An Example of an Affirmative SI Work Package')
      end
    end

    context 'Grom::Node does not have a name' do
      it 'returns an empty string' do
        expect(@work_packageble_thing.name).to eq('')
      end
    end
  end

  describe '#work_package' do
    context 'Grom::Node has a work package' do
      it 'returns a Grom::Node object' do
        expect(@work_packageble_thing.work_package.class).to eq(Grom::Node)
      end

      it 'returns a WorkPackage Grom::Node object' do
        expect(@work_packageble_thing.work_package.type).to eq('https://id.parliament.uk/schema/WorkPackage')
      end
    end

    context 'Grom::Node does not have a work package' do
      it 'returns nil' do
        expect(@work_packageble_thing.work_package).to eq(nil)
      end
    end
  end

  describe '#web_link' do
    context 'Grom::Node has a web link' do
      it 'returns a web link' do
        expect(@work_packageble_thing.web_link).to eq('http://www.legislation.gov.uk/ukdsi/2018/9780111169063')
      end
    end

    context 'Grom::Node has no web link' do
      it 'returns an empty string' do
        expect(@work_packageble_thing.web_link).to eq('')
      end
    end
  end
end
