# frozen_string_literal: true

# module ApplicationHelpers
#     def json_status(code, *data)
#       # this function receives 0 or 1 reason. NOT MORE THAN 1 REASON
#       # typically, when status is 204, no reason is provided
#       status code
#       {
#         :status => code,
#         :data => data[0]
#       }.to_json
#     end
# end

# This adds a method deep_sympoloze_keys in order to sympolize hashes of hashes thouout the aplicaiton.
class Object
  # transforms keys of hashes and arrays to symbols. Used in lafindumois-apr.rb as the
  # data received from front contains deep nested hashes with string keys
  def deep_symbolize_keys
    if is_a? Hash
      return each_with_object({}) do |(k, v), memo|
        memo[k.to_sym] = v.deep_symbolize_keys
      end
    end
    if is_a? Array
      return each_with_object([]) do |v, memo|
        memo << v.deep_symbolize_keys
      end
    end
    self
  end
end
