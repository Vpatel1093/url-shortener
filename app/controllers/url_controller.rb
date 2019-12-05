class UrlController < ApplicationController
  def new
  end

  def create
    respond_to do |format|
      @shortened_url = ShortenedUrl.new(original_url: url_param[:url])

      if @shortened_url.save
        format.json { render json: @shortened_url.shortened_url_token, status: :created }
      else
        format.json { render json: @shortened_url.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    shortened_url = ShortenedUrl.find_by(shortened_url_token: token_param[:shortened_url_token])

    unless shortened_url
      flash.now[:error] = 'Invalid url, please try again!'
      render :new
      return
    end

    redirect_to shortened_url.sanitized_original_url
  end

  private

  def url_param
    params.require(:shortened_url).permit(:url)
  end

  def token_param
    params.permit(:shortened_url_token)
  end
end
