module Sufia
  class WorkIndexer < CurationConcerns::WorkIndexer
    self.thumbnail_path_service = Sufia::WorkThumbnailPathService
    def generate_solr_document
      super.tap do |solr_doc|
        # This enables us to return a Work when we have a FileSet that matches
        # the search query.  While at the same time allowing us not to return Collections
        # when a work in the collection matches the query.
        solr_doc[Solrizer.solr_name('file_set_ids', :symbol)] = solr_doc[Solrizer.solr_name('member_ids', :symbol)]
        solr_doc[Solrizer.solr_name('resource_type', :facetable)] = object.resource_type
      end
    end
  end
end
