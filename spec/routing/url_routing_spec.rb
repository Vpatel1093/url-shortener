require 'rails_helper'

describe 'routing' do
  it 'routes for Urls' do
    expect(get('/')).to route_to(controller: 'url', action: 'new')
    expect(post('/shortened_urls')).to route_to(controller: 'url', action: 'create')
    expect(get('/abcdef')).to route_to(controller: 'url', action: 'show', shortened_url_token: 'abcdef')
  end
end
