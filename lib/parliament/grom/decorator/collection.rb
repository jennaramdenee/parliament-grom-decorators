module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: http://example.com/content/Collection
      # Collection Grom::Node is a Contentful object associated with a web article (a WebArticle has an Audience node)
      # Collection Grom::Node is not modelled in the data service, hence type 'http://example..' and not 'https://id.parliament.uk/schema'
      module Collection
        # Alias collectionName with fallback.
        #
        # @return [String, String] the name of the Grom::Node or an empty string.
        def name
          respond_to?(:collectionName) ? collectionName : ''
        end

        # Alias collectionDescription with fallback.
        #
        # @return [String, String] the description of the Grom::Node or an empty string.
        def description
          respond_to?(:collectionDescription) ? collectionDescription : ''
        end

        # Alias collectionExtendedDescription with fallback.
        #
        # @return [String, String] the extended description of the Grom::Node or an empty string.
        def extended_description
          respond_to?(:collectionExtendedDescription) ? collectionExtendedDescription : ''
        end

        # Alias collectionHasArticle with fallback.
        #
        # @return [Array, Array] an array of Articles related to the Grom::Node or an empty Array.
        def articles
          respond_to?(:collectionHasArticle) ? collectionHasArticle : []
        end

        # Alias collectionHasSubcollection with fallback.
        #
        # @return [Array, Array] an array of Subcollections related to the Grom::Node or an empty Array.
        def subcollections
          respond_to?(:collectionHasSubcollection) ? collectionHasSubcollection : []
        end

        # Alias collectionHasParent with fallback.
        #
        # @return [Array, Array] an array of Subcollections related to the Grom::Node or an empty Array.
        def parents
          respond_to?(:collectionHasParent) ? collectionHasParent : []
        end

        # Alias collectionHasCollectionsPaths with fallback.
        #
        # @return [Array, Array] an array of arrays of collection paths up the tree for the Grom::Node or an empty Array.
        def collections_paths
          respond_to?(:collectionHasCollectionsPaths) ? collectionHasCollectionsPaths : []
        end
      end
    end
  end
end
