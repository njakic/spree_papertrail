module Spree
  module Admin
    NavigationHelper.module_eval do
      def link_to_show(resource, options={})
        url = options[:url] || object_url(resource)
        options[:data] = {:action => 'show'}
        link_to_with_icon('eye', Spree.t(:show), url, options)
      end
    end
  end
end
