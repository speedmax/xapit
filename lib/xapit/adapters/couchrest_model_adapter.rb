module Xapit
  # This adapter is used for all DataMapper models. See AbstractAdapter for details.
  class CouchRestModelAdapter < AbstractAdapter
    def self.for_class?(member_class)
      member_class.ancestors.map(&:to_s).include? "CouchRest::ExtendedDocument"
    end
    
    # TODO override the rest of the methods here...
    def find_single(id)
      @target.get(id)
    end

    def find_multiple(ids)
      results = []
      
      ids.each do |id|
        results << @target.get(id)
      end

      results
    end

    def find_each(*args, &block)
      @target.all(*args).each do |record|
        yield record
      end
    end
  end
end
