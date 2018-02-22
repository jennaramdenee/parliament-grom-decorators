module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: http://example.com/content/Collection
      # Collection Grom::Node is a Contentful object associated with a web article (a WebArticle has an Audience node)
      # Collection Grom::Node is not modelled in the data service, hence type 'http://example..' and not 'https://id.parliament.uk/schema'
      module Collection
        # Alias name with fallback.
        #
        # @return [String, String] the title of the Grom::Node or an empty string.
        def collection_name
          respond_to?(:name) ? name : ''
        end

        # Alias description with fallback.
        #
        # @return [String, String] the title of the Grom::Node or an empty string.
        def collection_description
          respond_to?(:description) ? description : ''
        end
      end
    end
  end
end
