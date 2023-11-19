class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy set_completed remove_an_item add_an_item ]

  def index
    @orders = Order.open.includes(:coupon, :items)
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    if @order.save
			validate_code
			redirect_to order_url(@order), notice: "Order was successfully created."
		else
			render :new, status: :unprocessable_entity
		end
  end

  def update
		if @order.update(order_params)
				validate_code
				redirect_to order_url(@order), notice: "Order was successfully updated."
		else
				render :edit, status: :unprocessable_entity
		end
  end

  def destroy
    @order.destroy
		redirect_to orders_url, notice: "Order was successfully destroyed."
  end

  def set_completed
    @order = Order.find(params[:id])
    if @order.update(status: :completed)
			msg = "Order was successfully completed."
    else
			msg = @order.errors
    end
    redirect_to orders_path, notice: msg
	end

	def remove_an_item
		@orderItem = OrderItem.find_by(order_id: params[:id], item_id: params[:item_id])
		if @orderItem.destroy
			@order.save
			msg = "Item was successfully Deleted."
		else
			msg = @orderItem.errors
		end
		redirect_to orders_path, notice: msg
	end

	def add_an_item
		@orderItem = OrderItem.new(order_id: params[:id], item_id: params[:item_id])
		if @orderItem.save
			@order.save
			msg = "Item was successfully Added."
		else
			msg = @orderItem.errors
		end
		redirect_to orders_path, notice: msg
	end

  private
    def set_order
      @order = Order.find(params[:id])
    end
		
    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:status, :size)
    end
		
		def validate_code
			discount_code = params[:order][:coupon_id]
			promotion_code = params[:order][:coupon_id]
			if discount_code || promotion_code
				discount = Coupon.find_by(code: params[:order][:coupon_id]) if discount_code
				promotion = Promotion.find_by(code: params[:order][:promotion_id]) if promotion_code
				@order.update(coupon: discount, promotion: promotion)
			end
		end
end
