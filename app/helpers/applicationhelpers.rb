module ApplicationHelpers
=begin
    def json_status(code, *data)
      # this function receives 0 or 1 reason. NOT MORE THAN 1 REASON
      # typically, when status is 204, no reason is provided
      status code
      {
        :status => code,
        :data => data[0]
      }.to_json
    end
=end
end

class Object
  def deep_symbolize_keys
    # transforms keys of hashes and arrays to symbols. Used in lafindumois-apr.rb as the
    # data received from front contains deep nested hashes with string keys
    return self.inject({}){|memo,(k,v)| memo[k.to_sym] = v.deep_symbolize_keys; memo} if self.is_a? Hash
    return self.inject([]){|memo,v    | memo          << v.deep_symbolize_keys; memo} if self.is_a? Array
    return self
  end
end