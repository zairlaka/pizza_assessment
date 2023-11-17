class OrdersController < ApplicationController

    def update
        @order = Order.find(params[:id])
        if @order.update(status: :completed)
            msg = "Order was successfully updated."
        else
           msg = @order.errors
        end
        redirect_to orders_path, notice: msg
    end

    def index
        @orders = Order.open.includes(:coupon, :items)
    end

    def remove_an_item
        @orderItem = OrderItem.find_by(order_id: params[:id], item_id: params[:item_id])
        if @orderItem.destroy
            msg = "Item was successfully Deleted."
        else
           msg = @orderItem.errors
        end
        redirect_to orders_path, notice: msg
    end

    def add_an_item
        @orderItem = OrderItem.new(order_id: params[:id], item_id: params[:item_id])
        if @orderItem.save
            msg = "Item was successfully Added."
        else
           msg = @orderItem.errors
        end
        redirect_to orders_path, notice: msg
    end
end
