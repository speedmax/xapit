module Xapit
  # This adapter is used for all DataMapper models. See AbstractAdapter for details.
  class CouchRestModelAdapter < AbstractAdapter
    def self.for_class?(member_class)
      member_class.ancestors.map(&:to_s).include? "CouchRest::ExtendedDocument"
    end
    
    def find_single(id)
      @target.get(id)
    end

    # Get multiple documents
    def find_multiple(ids)
      @target.all(:keys => ids)
    end

    # Use CouchRest pagination for batched find_each
    def find_each(*args, &block)
      unless per_page = args.first[:per_page]
        per_page = 100
      end

      page  = 1
      loop !collection.empty? do
        collection = @target.all.paginate(:page => page, :per_page => per_page)
        collection.each do |record|
          yield record
        end
      end
    end
  end
end
