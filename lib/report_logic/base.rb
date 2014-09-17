module ReportLogic
  class Base
    attr_reader :collection
    attr_reader :decorators

    def initialize(collection = nil)
      @collection = collection
    end

    def each(key)
      return to_enum(__callee__, key) unless block_given?
      ensure_built
      fields[key] and fields[key].each { |field| yield field }
    end

    def group(key, collection = nil, &block)
      if collection
        fields[key] = []
        collection.each do |record|
          fields[key] << decorate_all(Grouper.new(record, &block).result, key)
        end
      else
        fields[key] = decorate_all(Grouper.new(&block).result, key)
      end
    end

    def decorators
      @decorators ||= {}
    end

    def add_decorator(group, decorator)
      decorators[group] ||= []
      decorators[group] << decorator
    end

    def decorate_all(fields, group = nil)
      decorators[group].each do |dec|
        fields.each do |field|
          dec.decorate(field)
        end
      end if decorators[group]
      decorate_all(fields) if group
      fields
    end

    protected

    def ensure_built
      build unless @built
      @built = true
    end

    def build
      raise NotImplementedError
    end

    private

    def fields
      @fields ||= {}
    end
  end
end
