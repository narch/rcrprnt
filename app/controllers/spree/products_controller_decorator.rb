module Spree
  module ProductsControllerDecorator
    def self.prepended(base)
      base.before_action :can_show_product, only: :show
    end


    def index
      @searcher = build_searcher(params.merge(include_images: true))
      @products = @searcher.retrieve_products
      @products = @products.includes(:possible_promotions) if @products.respond_to?(:includes)
      @taxonomies = get_taxonomies
    end

    def get_product_options
      @product = Spree::Product.find_by(id: params[:product_id])
      params[:option_value_ids].delete_if {|x| x == "Please Select" }
      params[:option_value_ids] = params[:option_value_ids].map(&:to_i)
      @variants = @product.option_value_variants.where(option_value_id: params[:option_value_ids]).group(:variant_id).having("count(variant_id) = #{params[:option_value_ids].count}").pluck(:variant_id)
      return @variant = Spree::Variant.find(@variants.first) if @variants.count == 1
      @options_hash = @product.options_hash(params[:option_value_ids], @variants)
    end

    private

    def can_show_product
      @product ||= Spree::Product.friendly.find(params[:id])
      if @product.stores.empty? || !@product.stores.include?(current_store)
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end

::Spree::ProductsController.prepend(Spree::ProductsControllerDecorator)
