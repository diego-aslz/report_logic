module ReportLogic
  class Base
    extend Forwardable

    attr_reader :collection

    def initialize(collection = nil)
      @collection = collection
    end

    def count
      @collection.size
    end

    def main_session
      @main_session ||= Session.new(nil, self)
    end

    def_delegators :main_session, :session, :decorate_with, :field, :value,
      :decorate, :children

    def each(*args, &block)
      ensure_built_and_decorated
      main_session.each(*args, &block)
    end

    protected

    def ensure_built_and_decorated
      build    unless @built
      decorate unless @decorated
      @built     = true
      @decorated = true
    end

    def build
      raise NotImplementedError
    end
  end
end
