module TestHelper
  def print_hash(hash, pad)
    hash.each do |key, value|
      if value.class.to_s == "Hash"
        concat render 'ocm_print', key: key, value: '', pad: pad
        print_hash(value, pad+30)
      else
        concat render 'ocm_print', key: key, value: value, pad: pad
      end
    end
  end
end
