module ProductsHelper

  def display_quantity_or_sell_out(product)
  return product.quantity > 0 ? product.quantity : ("<span class='sell-out'> \u{1F525} SELL OUT \u{1F525}
    </span>").html_safe
  end

    def display_add_to_cart_or_sold_out(product)
      return product.quantity > 0 ? (button_to "Add to bag", cart_entries_path(product_id: @product)).html_safe :   ("<button class='sold-out'>" + "SOLD OUT" + "</button>").html_safe
    end

    def display_edit_product_button?(product)
      if product.user == User.find_by(id: session[:user_id])
        (link_to "edit swag", edit_product_path(product.id)).html_safe
      end
    end

    def display_delete_product_button?(product)
      if product.user == User.find_by(id: session[:user_id])
        (link_to "delete swag", product_path, method: :delete, data: {confirm: "delete #{product.name}?"}).html_safe
      end
    end

    def get_product_average_rating(product)
      rating = 0.0
      count = 0.0
      if product.reviews
        product.reviews.each do |review|
          rating += review.rating
          count += 1
        end
      end
      count == 0.0 ? "Review this swag!" : ("%.1f" % (rating/count))
    end

    def show_product_reviews?(product)
      ("<li>" + "Swag Rating: #{get_product_average_rating(product)}" + "</li>").html_safe unless product.reviews.count == 0
    end
end
