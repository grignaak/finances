module Extras
module Accessors
  def attr_reader! name, *default, &block
    if(default.size >= 1)
      define_method name.to_sym do
        instance_variable_set("@#{name}", default[0]) unless instance_variable_defined?("@#{name}")
        instance_variable_get("@#{name}")
      end
    elsif block_given?
      define_method name.to_sym do
        instance_variable_set("@#{name}", instance_eval(&block)) unless instance_variable_defined?("@#{name}")
        instance_variable_get("@#{name}")
      end
    else
      attr_reader name
    end
  end

  def attr_accessor! name, *default, &block
    attr_reader! name, *default, &block
    define_method "#{name}=".to_sym do |value|
      instance_variable_set("@#{name}",value)
    end
  end
end
end
