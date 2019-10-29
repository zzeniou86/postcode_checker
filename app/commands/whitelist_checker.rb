#:nodoc
class WhitelistChecker
  prepend SimpleCommand

  def initialize(client, postcode, postcode_whitelist = [], lsoa_whitelist = [])
    @client = client
    @postcode = UKPostcode.parse(postcode)
    @postcode_whitelist = postcode_whitelist
    @lsoa_whitelist = lsoa_whitelist
  end

  def call
    return nil unless validate_postcode_format

    postcode_whitelisted? || lsoa_whitelisted?
  end

  private

  def validate_postcode_format
    return true if @postcode.full_valid?

    errors.add(:whitelist_checker, 'The postcode format is invalid. Please check if it\'s correct and try again')
    nil
  end

  def postcode_whitelisted?
    @postcode_whitelist.include?(@postcode.to_s)
  end

  def lsoa_whitelisted?
    pc = @postcode.to_s.delete(' ')
    response = @client.lookup(pc)
    return @lsoa_whitelist.any? { |lsoa| response['result']['lsoa'].include?(lsoa) } unless response.key?('error')

    errors.add(:whitelist_checker, response['error'])
    nil
  end
end
