require 'rails_helper'

describe UrlController do
  describe 'GET #new' do
    it 'renders new' do
      get :new

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:params) { { shortened_url: { url: "http://www.abc.com" } } }

    it 'calls ShortenedUrl.new.save' do
      creator = double(save: true, shortened_url_token: '123456')
      expect(ShortenedUrl).to receive(:new).with(original_url: 'http://www.abc.com').and_return(creator)
      expect(creator).to receive(:save)

      post :create, params: params, format: :json
    end

    context 'when successfully created' do
      before { allow_any_instance_of(ShortenedUrl).to receive(:save).and_return(true) }

      it 'returns created status' do
        post :create, params: params, format: :json

        expect(response).to have_http_status(:created)
      end
    end

    context 'when create failed' do
      before { allow_any_instance_of(ShortenedUrl).to receive(:save).and_return(false) }

      it 'returns 422 status' do
        post :create, params: params, format: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #show' do
    let(:shortened_url) { ShortenedUrl.create(original_url: 'http://www.abc.com') }

    context 'when the shortened url token exists' do
      let(:params) { { shortened_url_token: shortened_url.shortened_url_token } }

      it 'redirects to the original url' do
        get :show, params: params

        expect(response).to redirect_to('http://www.abc.com')
      end
    end

    context 'when the shortened url token cannot be found' do
      let(:params) { { shortened_url_token: 'badtoken' } }

      it 'redirects to new url with an error' do
        get :show, params: params

        expect(response).to render_template(:new)
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end
