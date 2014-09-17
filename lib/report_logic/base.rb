module ReportLogic
  class Base
    include Decorable

    attr_reader :collection

    def initialize(collection = nil)
      @collection = collection
    end

    def each(key)
      return to_enum(__callee__, key) unless block_given?
      ensure_built_and_decorated
      sessions[key] and sessions[key].fields.each { |field| yield field }
    end

    def session(key, collection = nil, &block)
      sess = sessions[key] ||= Session.new(key)
      sess.process(collection, &block)
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

    def decorate
      sessions.values.each do |sess|
        sess.decorate(@decorators)
      end
    end

    private

    def sessions
      @sessions ||= {}
    end
  end
end
