module Accessors
  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      var_name = "@#{attribute}"

      define_method(attribute) do
        instance_variable_get(var_name)
      end

      define_method("#{attribute}=") do |value|
        instance_variable_set("#{var_name}_history", []) unless instance_variable_get("#{var_name}_history")
        history = instance_variable_get("#{var_name}_history")
        history << instance_variable_get(var_name)
        instance_variable_set(var_name, value)
      end

      define_method("#{attribute}_history") do
        instance_variable_get("#{var_name}_history") || []
      end
    end
  end

  def strong_attr_accessor(attribute, klass)
    var_name = "@#{attribute}"

    define_method(attribute) do
      instance_variable_get(var_name)
    end

    define_method("#{attribute}=") do |value|
      raise TypeError, "Expected #{klass}, got #{value.class}" unless value.is_a?(klass)
      instance_variable_set(var_name, value)
    end
  end
end
