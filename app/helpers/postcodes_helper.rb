#:nodoc
module PostcodesHelper
  def lsoas_whitelist
    PC_WHITELIST[:lsoas]
  end

  def postcodes_whitelist
    PC_WHITELIST[:postcodes]
  end
end
