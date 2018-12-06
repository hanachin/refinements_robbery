require "refinements_robbery/version"
require "fiddle"

module RefinementsRobbery
  class Error < StandardError; end

  class << self
    def rob(klass)
      ObjectSpace.each_object(Module).select {|m|
        rb_refinement_module_get_refined_class(m) == klass
      }.map {|m|
        defined_at(m)
      }.uniq
    end

    private

    def rb_intern_str(str)
      rb_intern_str = Fiddle::Handle::DEFAULT["rb_intern_str"]
      rb_intern_str_f = Fiddle::Function.new(rb_intern_str, [Fiddle::TYPE_VOIDP], Fiddle::TYPE_VOIDP)
      rb_intern_str_f.call(Fiddle.dlwrap(str))
    end

    def rb_attr_get(mod, str)
      id = rb_intern_str(str)
      rb_attr_get = Fiddle::Handle::DEFAULT["rb_attr_get"]
      rb_attr_get_f = Fiddle::Function.new(rb_attr_get, [Fiddle::TYPE_VOIDP] * 2, Fiddle::TYPE_VOIDP)
      m = Fiddle.dlwrap(mod)
      Fiddle.dlunwrap(rb_attr_get_f.call(m, id))
    end

    def defined_at(mod)
      rb_attr_get(mod, "__defined_at__")
    end

    def rb_refinement_module_get_refined_class(mod)
      rb_attr_get(mod, "__refined_class__")
    end
  end
end
