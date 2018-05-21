require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::WorkPackageableThing, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).work_package_by_id.get
    @work_packageble_thing = (response.filter('https://id.parliament.uk/schema/WorkPackageableThing')).first
  end

  describe '#name' do
    context 'Grom::Node has a name' do
      it 'returns the name of the Grom::Node object' do
        expect(@work_packageble_thing.name).to eq('Lobsters and Crawfish (Prohibition of Fishing and Landing) (Amendment) (England) Order 2017')
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
        expect(@work_packageble_thing.web_link).to eq('https://www.legislation.gov.uk/uksi/2017/899/made')
      end
    end

    context 'Grom::Node has no web link' do
      it 'returns an empty string' do
        expect(@work_packageble_thing.web_link).to eq('')
      end
    end
  end

  describe '#work_package_and_business_items' do
    context 'Grom::Node has both a work package and business items' do
      it 'returns true' do
        expect(@work_packageble_thing.work_package_and_business_items?).to eq(true)
      end
    end

    context 'Grom::Node does not have a work package' do
      it 'returns false' do
        expect(@work_packageble_thing.work_package_and_business_items?).to eq(false)
      end
    end

    context 'Grom::Node has a work package but no business items' do
      it 'returns false' do
        expect(@work_packageble_thing.work_package_and_business_items?).to eq(false)
      end
    end
  end

  describe '#laying_business_item' do
    context 'Grom::Node has a laying business item' do
      xit 'returns a laying business item Grom::Node' do
        expect(@work_packageble_thing.laying_business_item.type).to include('https://id.parliament.uk/schema/BusinessItem')
      end
    end

    context 'Grom::Node does not have a laying business item' do
      xit 'returns an empty array' do
        expect(@work_packageble_thing.laying_business_item).to eq(nil)
      end
    end
  end

  describe '#laying_business_item_date' do
    context 'Grom::Node has a date' do
      xit 'returns a date' do
        expect(@work_packageble_thing.laying_business_item_date).to eq(DateTime.new(2018, 4, 30, 0, 0, 0))
      end
    end

    context 'Grom::Node has no date' do
      xit 'returns nil' do
        expect(@work_packageble_thing.laying_business_item_date).to eq(nil)
      end
    end
  end

  describe '#oldest_business_item' do
    context 'Grom::Node has an oldest business item' do
      it 'returns a business item Grom::Node' do
        expect(@work_packageble_thing.oldest_business_item.type).to include('https://id.parliament.uk/schema/BusinessItem')
      end
    end

    context 'Grom::Node does not have an oldest business item' do
      it 'returns nil' do
        expect(@work_packageble_thing.oldest_business_item).to eq(nil)
      end
    end
  end

  describe '#oldest_business_item_date' do
    context 'Grom::Node has an oldest business item date' do
      it 'returns a date' do
        expect(@work_packageble_thing.oldest_business_item_date).to eq(DateTime.new(2017,11,15,0,0,0))
      end
    end

    context 'Grom::Node has an oldest business item with no date' do
      it 'returns nil' do
        expect(@work_packageble_thing.oldest_business_item_date).to eq(nil)
      end
    end

    context 'Grom::Node does not have any business items' do
      it 'returns nil' do
        expect(@work_packageble_thing.oldest_business_item_date).to eq(nil)
      end
    end
  end

  describe '#coming_into_force_date' do
    context 'Grom::Node has a coming into force date' do
      it 'returns a date' do
        expect(@work_packageble_thing.coming_into_force_date).to eq(DateTime.new(2017,10,01))
      end
    end

    context 'Grom::Node has no coming into force date' do
      it 'returns nil' do
        expect(@work_packageble_thing.coming_into_force_date).to eq(nil)
      end
    end
  end

  describe '#time_limit_for_objection_date' do
    context 'Grom::Node has a time limit for objection date' do
      it 'returns a date' do
        expect(@work_packageble_thing.time_limit_for_objection_date).to eq(DateTime.new(2018,05,22))
      end
    end

    context 'Grom::Node has no time limit for objection date' do
      it 'returns nil' do
        expect(@work_packageble_thing.time_limit_for_objection_date).to eq(nil)
      end
    end
  end

  describe '#proposed_statutory_instrument' do
    context 'Grom::Node is a proposed statutory instrument' do
      it 'returns true' do
        expect(@work_packageble_thing.proposed_statutory_instrument?).to eq(true)
      end
    end

    context 'Grom::Node is not a proposed statutory instrument' do
      it 'returns false' do
        expect(@work_packageble_thing.proposed_statutory_instrument?).to eq(false)
      end
    end
  end

  describe '#statutory_instrument' do
    context 'Grom::Node is a statutory instrument' do
      it 'returns true' do
        expect(@work_packageble_thing.statutory_instrument?).to eq(true)
      end
    end

    context 'Grom::Node is not a statutory instrument' do
      it 'returns false' do
        expect(@work_packageble_thing.statutory_instrument?).to eq(false)
      end
    end
  end

  describe '#work_packageable_thing_type' do
    context 'Grom::Node is a statutory instrument' do
      it 'returns SI' do
        expect(@work_packageble_thing.work_packageable_thing_type).to eq('statutory instrument')
      end
    end

    context 'Grom::Node is a proposed statutory instrument' do
      it 'returns proposed SI' do
        expect(@work_packageble_thing.work_packageable_thing_type).to eq('proposed statutory instrument')
      end
    end

    context 'Grom::Node is not a statutory instrument' do
      it 'returns nil' do
        expect(@work_packageble_thing.work_packageable_thing_type).to eq(nil)
      end
    end
  end
end
