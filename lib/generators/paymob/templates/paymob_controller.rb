# frozen_string_literal: true

# class PaymobController < ActionController::API
#   def transaction_response
#     if params[:success] && Hmac.matches_original?(transaction_response_params.to_h, params[:hmac])
#       # Success logic
#     else
#       # Failure logic
#     end
#   end

#   def transaction_callback
#     if params[:success] && Hmac.matches_original?(transaction_callback_params.to_h, params[:hmac])
#       # Success logic
#     else
#       # Failure logic
#     end
#   end

#   private

#   def transaction_response_params
#     params
#       .permit(
#         :amount_cents, :created_at, :currency, :error_occured,
#         :has_parent_transaction, :id, :integration_id, :is_3d_secure, :is_auth, :is_capture,
#         :is_refunded, :is_standalone_payment, :is_voided, :owner, :pending, :success,
#         :'source_data.pan', :'source_data.sub_type', :'source_data.type', :order
#       )
#   end

#   def transaction_callback_params
#     params
#       .require(:obj)
#       .permit(
#         :amount_cents, :created_at, :currency, :error_occured,
#         :has_parent_transaction, :id, :integration_id, :is_3d_secure, :is_auth, :is_capture,
#         :is_refunded, :is_standalone_payment, :is_voided, :owner, :pending, :success, source_data:
#       %i[pan sub_type type], order: %i[id]
#       )
#   end
# end
