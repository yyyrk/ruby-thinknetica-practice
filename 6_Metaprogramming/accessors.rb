module Accessors
  def attr_accessor_with_history(*args)
    args.each do |attr_name|
      variable = "@#{attr_name}"
      variable_history = "@#{attr_name}_history"


      define_method(attr_name) { instance_variable_get(variable) }


      define_method("#{attr_name}_history") do
        instance_variable_get(variable_history) || []
      end


      define_method("#{attr_name}=") do |value|
        history = instance_variable_get(variable_history) || []
        history << value
        instance_variable_set(variable_history, history)
        instance_variable_set(variable, value)
      end
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    variable = "@#{attr_name}"

    define_method(attr_name) { instance_variable_get(variable) }

    define_method("#{attr_name}=") do |value|
      unless value.is_a?(attr_class)
        raise ArgumentError, "Класс присваемого значения #{value.class}, а должен быть #{attr_class}"
      end

      instance_variable_set(variable, value)
    end
  end
end
