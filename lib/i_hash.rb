class IHash < Hash
  def symbolize_keys
    IHash.symbolize(self)
  end

  def stringify_keys
    IHash.stringify(self)
  end

  def compare(other_hash)
    current_hash = IHash.symbolize(self)
    other_hash = IHash.symbolize(other_hash)
    (current_hash.keys | other_hash.keys).each_with_object({}) do |k, diff|
      current_hash_key = current_hash[k]
      other_hash_key = other_hash[k]
      if current_hash_key != other_hash_key
        diff[k] = [current_hash_key, other_hash_key]
        next unless current_hash_key.is_a?(Hash) && other_hash_key.is_a?(Hash)

        diff[k] = deep_diff(current_hash_key, other_hash_key)
      end
      diff
    end
  end

  class << self
    def symbolize(obj)
      if obj.is_a? Hash
        return obj.inject({}) do |memo, (k, v)|
          memo.tap { |m| m[k.to_sym] = symbolize(v) }
        end
      elsif obj.is_a? Array
        return obj.map { |memo| symbolize(memo) }
      end
      obj
    end

    def stringify(obj)
      if obj.is_a? Hash
        return obj.inject({}) do |memo, (k, v)|
          memo.tap { |m| m[k.to_s] = stringify(v) }
        end
      elsif obj.is_a? Array
        return obj.map { |memo| stringify(memo) }
      end
      obj
    end
  end
end

# Modify `Object`
class Object
  def deep_symbolize_keys
    return self.reduce({}) do |memo, (k, v)|
      memo.tap { |m| m[k.to_sym] = v.deep_symbolize_keys }
    end if self.is_a? Hash
    return self.reduce([]) do |memo, v| 
      memo << v.deep_symbolize_keys; memo
    end if self.is_a? Array
    self
  end

  def deep_stringify_keys
    return self.reduce({}) do |memo, (k, v)|
      memo.tap { |m| m[k.to_s] = v.deep_stringify_keys }
    end if self.is_a? Hash
    return self.reduce([]) do |memo, v| 
      memo << v.deep_stringify_keys; memo
    end if self.is_a? Array
    self
  end
end
