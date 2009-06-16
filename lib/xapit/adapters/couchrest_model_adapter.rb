module Xapit
  # This adapter is used for all DataMapper models. See AbstractAdapter for details.
  class CouchRestModelAdapter < AbstractAdapter
    def self.for_class?(member_class)
      member_class.ancestors.map(&:to_s).include? "CouchRest::ExtendedDocument"
    end
    
    # TODO override the rest of the methods here...
    def find_single(id)
      @target.find(id)
    end

    def find_multiple(ids)
      @target.find(ids)
    end

    def find_each(*args, &block)
      @target.find_each(*args, &block)
    end
  end
end
