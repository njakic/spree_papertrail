Deface::Override.new  virtual_path: 'spree/admin/shared/_order_tabs',
                      name: 'add_versions_to_order_tabs',
                      original: '7b867e69b2e5644950f335b56b80e85740acfcf2',
                      insert_bottom: "[data-hook='admin_order_tabs']",
                      text: "
                        <%= content_tag :li, :class => ('active' if current == Spree.t(:order_versions)) do %>
                          <%= link_to_with_icon 'history', Spree.t(:order_versions), admin_order_order_versions_path(@order) %>
                        <% end %>
                      "
