module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(attribute, validation_type, *params)
      @validations ||= []
      @validations << { attribute: attribute, type: validation_type, params: params }
    end

    def validations
      @validations || []
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attribute_value = instance_variable_get("@#{validation[:attribute]}")
        send("validate_#{validation[:type]}", attribute_value, *validation[:params])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate_presence(value)
      raise 'Значение не может быть пустым или nil!' if value.nil? || value.to_s.strip.empty?
    end

    def validate_format(value, format)
      raise 'Значение не соответствует формату!' if value !~ format
    end

    def validate_type(value, type)
      raise 'Значение не соответствует типу!' unless value.is_a?(type)
    end
  end
end
