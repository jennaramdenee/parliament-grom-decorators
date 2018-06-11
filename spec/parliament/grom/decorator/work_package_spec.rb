require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::WorkPackage, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).work_package_by_id.get
    @work_package = (response.filter('https://id.parliament.uk/schema/WorkPackage')).first
  end

  describe '#procedure' do
    context 'Grom::Node has a procedure' do
      it 'returns an array of procedure Grom::Nodes for the Grom::Node object' do
        expect(@work_package.procedure.type).to eq('https://id.parliament.uk/schema/Procedure')
      end
    end

    context 'Grom::Node does not have a procedure' do
      it 'returns nil' do
        expect(@work_package.procedure).to eq(nil)
      end
    end
  end

  describe '#work_packageable_thing' do
    context 'Grom::Node has a work packageable thing' do
      it 'returns an array of procedure Grom::Nodes for the Grom::Node object' do
        expect(@work_package.work_packageable_thing.type).to include('https://id.parliament.uk/schema/WorkPackageableThing')
      end
    end

    context 'Grom::Node does not have a work packageable thing' do
      it 'returns nil' do
        expect(@work_package.work_packageable_thing).to eq(nil)
      end
    end
  end

  describe '#work_packageable_thing_name' do
    context 'Grom::Node has a work packageable thing with a name' do
      it 'returns the name of the Grom::Node object' do
        expect(@work_package.work_packageable_thing_name).to eq('Andrey Lugovoy and Dmitri Kovtun Freezing Order 2018')
      end
    end

    context 'Grom::Node has a work packageable thing but no name' do
      it 'returns nil' do
        expect(@work_package.work_packageable_thing_name).to eq('')
      end
    end

    context 'Grom::Node has no work packageable thing' do
      it 'returns nil' do
        expect(@work_package.work_packageable_thing_name).to eq(nil)
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

  describe '#oldest_business_item_date' do
    context 'Grom::Node has an oldest business item date' do
      it 'returns a date' do
        expect(@work_package.oldest_business_item_date).to eq(DateTime.new(2018,04,30,0,0,0))
      end
    end

    context 'Grom::Node has an oldest business item with no date' do
      it 'returns nil' do
        expect(@work_package.oldest_business_item_date).to eq(nil)
      end
    end

    context 'Grom::Node does not have any business items' do
      it 'returns nil' do
        expect(@work_package.oldest_business_item_date).to eq(nil)
      end
    end
  end

  describe '#current' do
    context 'expiration' do
      context 'when work package has expired' do
        it 'returns false' do
          expect(@work_package.current?).to eq(false)
        end
      end

      context 'when work package has not expired' do
        it 'returns true' do
          expect(@work_package.current?).to eq(true)
        end
      end
    end

    context 'withdrawn' do
      context 'when work package has been withdrawn' do
        it 'returns false' do
          expect(@work_package.current?).to eq(false)
        end
      end

      context 'when work package has not been withdrawn' do
        it 'returns true' do
          expect(@work_package.current?).to eq(true)
        end
      end
    end

    context 'decision made' do
      context 'when work package has had a decision made' do
        it 'returns false' do
          expect(@work_package.current?).to eq(false)
        end
      end

      context 'when work package has not had a decision made' do
        it 'returns true' do
          expect(@work_package.current?).to eq(true)
        end
      end
    end
  end

  describe 'withdrawn' do
    pending
  end

  describe 'expired' do
    context 'end of 40 day time limit' do
      context 'has been actualised' do
        it 'returns true' do
          expect(@work_package.expired?).to eq(true)
        end
      end

      context 'has not been actualised' do
        it 'returns false' do
          expect(@work_package.expired?).to eq(false)
        end
      end
    end

    context 'end of time limit for approval' do
      context 'has been actualised' do
        it 'returns true' do
          expect(@work_package.expired?).to eq(true)
        end
      end

      context 'has not been actualised' do
        it 'returns false' do
          expect(@work_package.expired?).to eq(false)
        end
      end
    end
  end

  describe 'decision_made' do
    context 'when approved' do
      it 'returns true' do
        expect(@work_package.decision_made?).to eq(true)
      end

    end
    context 'when rejected' do
      it 'returns true' do
        expect(@work_package.decision_made?).to eq(true)
      end
    end

    context 'when neither approved or rejected' do
      it 'returns false' do
        expect(@work_package.decision_made?).to eq(false)
      end
    end
  end

  describe 'approved' do
    context 'by both houses' do
      context 'has been actualised' do
        it 'returns true' do
          expect(@work_package.approved?).to eq(true)
        end
      end

      context 'has not been actualised' do
        it 'returns false' do
          expect(@work_package.approved?).to eq(false)
        end
      end
    end

    context 'end of time limit for approval' do
      context 'has been actualised' do
        it 'returns true' do
          expect(@work_package.approved?).to eq(true)
        end
      end

      context 'has not been actualised' do
        it 'returns false' do
          expect(@work_package.approved?).to eq(false)
        end
      end
    end
  end

  describe 'rejected' do
    context 'instrument rejected and ceases to be law' do
      context 'has been actualised' do
        it 'returns true' do
          expect(@work_package.rejected?).to eq(true)
        end
      end

      context 'has not been actualised' do
        it 'returns false' do
          expect(@work_package.rejected?).to eq(false)
        end
      end
    end

    context 'instrument annulled' do
      context 'has been actualised' do
        it 'returns true' do
          expect(@work_package.rejected?).to eq(true)
        end
      end

      context 'has not been actualised' do
        it 'returns false' do
          expect(@work_package.rejected?).to eq(false)
        end
      end
    end

    context 'instrument cannot be made law' do
      context 'has been actualised' do
        it 'returns true' do
          expect(@work_package.rejected?).to eq(true)
        end
      end

      context 'has not been actualised' do
        it 'returns false' do
          expect(@work_package.rejected?).to eq(false)
        end
      end
    end
  end
end
