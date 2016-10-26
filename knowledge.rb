class Module
  def attribute(property, &block)

    property, property_value = property.first if property.is_a?(Hash)

    define_method(property + '=') { |value| instance_variable_set("@#{property}", value)}

    define_method(property + '?') { self.send(property) }

    define_method(property) do
      unless instance_variable_defined?("@#{property}")
        instance_variable_set("@#{property}", block ? instance_eval(&block) : property_value)
      end
      instance_variable_get("@#{property}")
    end
  end
end
