module ReportLogic
  class Base
    attr_reader :collection

    def initialize(collection)
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
          fields[key] << Grouper.new(record, &block).result
        end
      else
        fields[key] = Grouper.new(&block).result
      end
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
