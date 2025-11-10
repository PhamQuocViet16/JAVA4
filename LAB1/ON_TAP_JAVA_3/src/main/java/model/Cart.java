package model;

import java.util.ArrayList;
import java.util.List;

public class Cart 
{
	private List<CartItem> items;

    public Cart() {
        this.items = new ArrayList<>();
    }

    // Thêm sản phẩm vào giỏ hàng
    public void addItem(Item item, int quantity) {
        for (CartItem cartItem : items) {
            if (cartItem.getItem().getName().equals(item.getName())) {
                cartItem.setQuantity(cartItem.getQuantity() + quantity);
                return;
            }
        }
        items.add(new CartItem(item, quantity));
    }

    // Xóa sản phẩm khỏi giỏ hàng
    public void removeItem(String itemName) {
        items.removeIf(cartItem -> cartItem.getItem().getName().equals(itemName));
    }

    // Cập nhật số lượng sản phẩm
    public void updateItemQuantity(String itemName, int quantity) {
        for (CartItem cartItem : items) {
            if (cartItem.getItem().getName().equals(itemName)) {
                cartItem.setQuantity(quantity);
                return;
            }
        }
    }

    // Tính tổng giá trị giỏ hàng
    public double getTotalPrice() {
        double total = 0;
        for (CartItem cartItem : items) {
            total += cartItem.getTotalPrice();
        }
        return total;
    }

    public List<CartItem> getItems() {
        return items;
    }
}
