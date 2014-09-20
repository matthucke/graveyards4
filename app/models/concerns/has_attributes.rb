module HasAttributes
  extend ActiveSupport::Concern

  def attributes=(attrs)
    if attrs && attrs.respond_to?(:keys)
      attrs.keys.each do |k|
        if respond_to?("#{k}=")
          send "#{k}=", attrs[k]
        end
      end
    end
    self
  end

  def set_attributes(attrs, opts={})
    self.attributes=filter_attribute_hash(attrs, opts)
  end

  def filter_attribute_hash(attrs, opts={})
    if white_list=opts[:only]
      attrs = attrs.slice(*white_list)
    end
    if skip_list=opts[:except]
      attrs = attrs.slice( *(attrs.keys - skip_list.to_a))
    end
    attrs
  end

  def initialize(attrs)
    self.attributes=attrs
  end
end