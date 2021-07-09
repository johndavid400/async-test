class AsyncController < ApplicationController

  def index
  end

  def kitten
    @image = get_cat_image
  end

  private

  def get_cat_image
    url = 'https://api.thecatapi.com/v1/images/search'
    resp = Net::HTTP.get(URI(url))
    JSON.parse(resp)[0]['url']
  end

end
