#:nodoc
class PostcodesController < ApplicationController
  def index; end

  def check_whitelist
    client = PostcodesIo::Client.new
    postcode = params['query']
    lsoas_whitelist = helpers.lsoas_whitelist
    postcodes_whitelist = helpers.postcodes_whitelist

    command = PostcodeChecker.call(client, postcode, postcodes_whitelist, lsoas_whitelist)

    if command.success?
      @result = command.result
    else
      @errors = command.errors
      render status: :bad_request
    end
  end
end
