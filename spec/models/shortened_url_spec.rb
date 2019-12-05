require 'rails_helper'

describe ShortenedUrl do
  describe 'validations' do
    it { should allow_value('http://www.abc.com').for(:original_url) }
    it { should allow_value('https://www.abc.com').for(:original_url) }
    it { should allow_value('www.abc.com').for(:original_url) }
    it { should allow_value('https://www.google.com/search?q=url+shortener&oq=google+u&aqs \
      =chrome.0.69i59j69i60l3j0j69i57.1069j0j7&sourceid=chrome&ie=UTF-8').for(:original_url) }
    it { should_not allow_value('').for(:original_url) }
    it { should_not allow_value(' ').for(:original_url) }
    it { should_not allow_value('abc').for(:original_url) }
    it { should_not allow_value('123').for(:original_url) }
    it { should_not allow_value('.com').for(:original_url) }
  end

  describe '#create_shortened_url' do
    let(:shortened_url) { ShortenedUrl.create(original_url: 'http://abc.com') }

    it 'creates a six digit alphanumeric token' do
      token = shortened_url.shortened_url_token
      is_alphanumberic = !token.match(/\A[a-z0-9]*\z/).nil?

      expect(token.length).to eq(6)
      expect(is_alphanumberic).to be_truthy
    end
  end

  describe '#create_sanitized_original_url' do
    subject { shortened_url.sanitized_original_url }

    context "when the original url starts with 'http'" do
      let(:shortened_url) { ShortenedUrl.create(original_url: 'http://abc.com') }
      it { is_expected.to eq('http://abc.com') }
    end

    context "when the original url starts with 'https'" do
      let(:shortened_url) { ShortenedUrl.create(original_url: 'https://abc.com') }
      it { is_expected.to eq('https://abc.com') }
    end

    context "when the original url does not start with 'http' or 'https'" do
      let(:shortened_url) { ShortenedUrl.create(original_url: 'abc.com') }
      it { is_expected.to eq('http://abc.com') }
    end
  end
end
