module InstanceCounter
  def self.included(current_class)
    current_class.extend ClassMethods
    current_class.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances

    def add_instance
      @instances = @instances.to_i + 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.add_instance
    end
  end
end
