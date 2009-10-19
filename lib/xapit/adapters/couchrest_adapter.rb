module Xapit
  # This adapter is used for all CouchRest::ExtendedDocument objects
  class CouchrestAdapter < AbstractAdapter
    def self.for_class?(member_class)
      member_class.ancestors.map(&:to_s).include? "CouchRest::ExtendedDocument"
    end
    
    # TODO override the rest of the methods here...
    def find_single(id)
      @target.get(id)
    end

    # Get multiple documents
    def find_multiple(ids)
      @target.all(:keys => ids)
    end

    # Use CouchRest pagination for batched find_each
    def find_each(view = :all, query = {}, &block)
      page  = 1

      # set batch size option
      unless batch_size = query.delete(:batch_size)
        batch_size = 200
      end

      begin
        # Fetch one batch of records
        collection = @target.view(view, query).paginate(
          :page => page, :per_page => batch_size
        )

        collection.each do |record|
          yield record
        end

        page += 1
      end while not collection.empty? 
    end
  end
end
