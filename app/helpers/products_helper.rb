module ProductsHelper

  def display_quantity_or_sell_out(product)
    if product.quantity > 0
      product.quantity
    else
      return ("<span class='sell-out'> 🔥 SELL OUT 🔥
        </span>").html_safe
      end
    end

    def display_add_to_cart_or_sold_out(product)
      if product.quantity > 0
        (button_to "Add to cart", cart_entries_path(product_id: @product)).html_safe
      else
        ("<button class='sold-out'>" + "SOLD OUT" + "</button>").html_safe
      end
    end

    def display_edit_product_button?(product)
      if product.user == User.find_by(id: session[:user_id])
        (link_to "Edit", edit_product_path(product.id)).html_safe
      end
    end

    def display_delete_product_button?(product)
      if product.user == User.find_by(id: session[:user_id])
        (link_to "Delete", product_path, method: :delete, data: {confirm: "Delete  #{product.name}?"}).html_safe
      end
    end
end
    # <button></button>
