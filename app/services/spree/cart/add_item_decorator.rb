# module Spree
#   module Cart
#     module AddItemDecorator
#
#       private
#
#       def add_to_line_item(order:, variant:, quantity: nil, options: {})
#         options ||= {}
#         quantity ||= 1
#
#         opts = ::Spree::PermittedAttributes.line_item_attributes.flatten.each_with_object({}) do |attribute, result|
#           result[attribute] = options[attribute]
#         end.merge(currency: order.currency).delete_if { |_key, value| value.nil? }
#
#         line_item = order.line_items.new(quantity: quantity,
#                                          variant: variant,
#                                          options: opts)
#
#         line_item.target_shipment = options[:shipment] if options.key? :shipment
#
#         return failure(line_item) unless line_item.save
#
#         line_item.reload.update_price
#
#         line_item_created = true
#
#         ::Spree::TaxRate.adjust(order, [line_item]) if line_item_created
#         success(order: order, line_item: line_item, line_item_created: line_item_created, options: options)
#       end
#     end
#   end
# end
#
# ::Spree::Cart::AddItem.prepend ::Spree::Cart::AddItemDecorator
