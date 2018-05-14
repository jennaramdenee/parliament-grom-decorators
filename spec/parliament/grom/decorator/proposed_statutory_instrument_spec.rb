require_relative '../../../spec_helper'

describe Parliament::Grom::Decorator::ProposedStatutoryInstrument, vcr: true do
  before(:each) do
    response = Parliament::Request::UrlRequest.new(
      base_url: 'http://localhost:3030/api/v1',
      builder: Parliament::Builder::NTripleResponseBuilder,
      decorators: Parliament::Grom::Decorator).work_package_by_id.get
    @proposed_statutory_instrument = (response.filter('https://id.parliament.uk/schema/ProposedStatutoryInstrument')).first
  end

  describe '#number_prefix' do
  end
end
