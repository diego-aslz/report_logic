module ReportLogic
  class Session
    include Decorable

    attr_accessor :key

    def initialize(key)
      @key = key
    end

    def fields
      @fields ||= []
    end

    def current_row
      @current_row ||= fields
    end

    def field(name, value = nil, **options)
      current_row << Field.new(name, value, **options)
    end

    def value(val, **options)
      field(nil, val, **options)
    end

    def process(collection = nil, &block)
      if collection.respond_to?(:each)
        collection.each do |record|
          @current_row = []
          instance_exec record, &block
          fields.push current_row
          @current_row = nil
        end
      else
        instance_exec &block
      end
    end

    def decorate(global_decorators = nil)
      decorate_with(global_decorators) if global_decorators
      decorate_with(decorators)
    end

    def decorate_with(decorators)
      decorators.each do |dec|
        fields.each do |field|
          dec.decorate_if_matches(field)
        end
      end
      fields
    end
  end
end
