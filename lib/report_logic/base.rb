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
      @current_session = sessions[key] ||= Session.new(key, self)
      @current_session.process(collection, &block)
    ensure
      @current_session = nil
    end

    def count
      @collection.size
    end

    def method_missing(method_name, *args, &block)
      if @current_session && @current_session.public_methods.include?(method_name)
        @current_session.public_send(method_name, *args, &block)
      else
        super
      end
    end

    def decorate_with(*args)
      if @current_session
        @current_session.decorate_with(*args)
      else
        super
      end
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
