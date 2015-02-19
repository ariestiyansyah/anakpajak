class PaymentsController < ApplicationController
  protect_from_forgery except: [:hook]

  def create
    @payment = Payment.new
    @payment.amount = params[:total_payment]
    @payment.npwp   = params[:npwp]
    @payment.status = false
    @payment.user   = current_user
    if @payment.save
      redirect_to @payment.paypal_url(payment_path(@payment))
    else
      render :new
    end
  end

  def index
    @payment = Payment.new
    respond_to do |format|
      format.js
    end
  end

  def hook
    payment_status = params[:payment_status]
    if payment_status == "Completed"
      @payment = Payment.find_by_id params[:invoice]
      @payment.update_attributes notification_params: params, status: true, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end
  def show
    redirect_to root_path
  end

end
