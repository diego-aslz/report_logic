module ReportLogic
  class Session
    include Decorable

    attr_accessor :key, :report

    def initialize(key = nil, report = nil)
      @key, @report = key, report
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
          begin
            @current_row = []
            instance_exec record, &block
            fields.push current_row
          ensure
            @current_row = nil
          end
        end
      else
        instance_exec &block
      end
    end

    def decorate(master_decorators = nil)
      master_decorators ||= []
      fields.each do |field_or_row|
        if field_or_row.respond_to?(:each)
          field_or_row.each { |f| f.decorate(master_decorators + decorators) }
        else
          field_or_row.decorate(master_decorators + decorators)
        end
      end
      children.each do |_, sess|
        sess.decorate(decorators)
      end
    end

    def each(key)
      return to_enum(__callee__, key) unless block_given?
      children[key] and children[key].fields.each { |field| yield field }
    end

    def session(key, collection = nil, &block)
      sess = children[key] ||= Session.new(key, @report)
      sess.process(collection, &block)
    end

    protected

    def children
      @children ||= {}
    end
  end
end
