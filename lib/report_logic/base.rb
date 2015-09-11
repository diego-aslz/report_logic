module ReportLogic
  class Base
    attr_reader :collection

    def initialize(collection = nil)
      @collection = collection
    end

    def fields(&block)
      @current = []
      instance_exec &block
      @current
    end

    def collection_fields(&block)
      collection.map do |record|
        fields do
          instance_exec record, &block
        end
      end
    end

    def self.session(key, &block)
      define_method key do
        @current = []
        instance_eval &block
        @current
      end
    end

    def self.collection_session(key, &block)
      define_method key do
        collection_fields &block
      end
    end

    def each(key)
      fail '`each` is not used anymore. Please, refer to the project\'s '\
           ' documentation on Github for more details.'
    end

    def session(key, collection = nil, &block)
      fail '`session` is not used anymore. Please, refer to the project\'s '\
           ' documentation on Github for more details.'
    end

    def count
      collection.size
    end

    protected

    def field(name, value = nil, **options)
      @current << Field.new(name, value, **options)
    end

    def value(val, **options)
      field(nil, val, **options)
    end
  end
end
