#:nodoc
class PostcodesController < ApplicationController
  def index; end

  def check_whitelist
    command = WhitelistChecker.call(PostcodesIo::Client.new,
                                    params['query'],
                                    helpers.postcodes_whitelist,
                                    helpers.lsoas_whitelist)
                                    
    if command.success?
      @result = command.result
    else
      @errors = command.errors
      render status: :bad_request
    end
  end
end
