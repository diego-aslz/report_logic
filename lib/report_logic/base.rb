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
          fields[key] << decorate_all(Grouper.new(record, group: key, &block).result)
        end
      else
        fields[key] = decorate_all(Grouper.new(group: key, &block).result)
      end
    end

    def decorators
      @decorators ||= []
    end

    def decorate_all(fields)
      decorators.each do |dec|
        fields.each do |field|
          dec.decorate_if_matches(field)
        end
      end
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
