class Instructors::MerchantsController < ApplicationController

  before_action :authenticate_instructor!
  before_action :correct_instructor
  before_action :set_instructor
  before_action :have_merchant_account, only: [:new, :create]

  def new
    @merchant = Merchant.new
  end

  def create

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    @account = Stripe::Account.create(
      type: 'custom',
      country: (params[:merchant][:country])[0,2],
      email: @instructor.email,
      tos_acceptance: {
        ip: request.remote_ip,
        date: Time.now.to_i
      },
      legal_entity: {
        dob: {
          month: params[:merchant][:month],
          day: params[:merchant][:day],
          year: params[:merchant][:year]
        },
        first_name: params[:merchant][:first_name],
        last_name: params[:merchant][:last_name],
        type: 'individual'
      }
    )

    if @account.save
      @merchant = @instructor.create_merchant(
        first_name: @account.legal_entity.first_name,
        last_name: @account.legal_entity.last_name,
        month: @account.legal_entity.dob.month,
        day: @account.legal_entity.dob.day,
        year: @account.legal_entity.dob.year,
        currency: @account.default_currency,
        country: @account.country,
        stripe_id: @account.id
      )
      redirect_to edit_instructor_merchant_path(@instructor, @merchant)
      flash[:notice] = "Before we can transfer your payments we need more information."
    else
      redirect_to instructor_path(@instructor)
      flash[:alert] = "Your merchant account failed to create."
    end

  end

  def edit
    @merchant = @instructor.merchant

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    @account = Stripe::Account.retrieve(@merchant.stripe_id)
  end

  def update
    @merchant = @instructor.merchant

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    account = Stripe::Account.retrieve(@merchant.stripe_id)

    if params[:merchant][:bank_account_number].present?
      account.external_accounts.create(
        external_account: {
          object: 'bank_account',
          account_number: params[:merchant][:bank_account_number],
          routing_number: params[:merchant][:bank_routing_number],
          country: account.country,
          currency: params[:merchant][:currency]
        }
      )
    end

    account.legal_entity.address.line1 = params[:merchant][:line1]
    account.legal_entity.address.city = params[:merchant][:city]
    account.legal_entity.address.postal_code = params[:merchant][:postal_code]
    account.legal_entity.personal_address.line1 = params[:merchant][:line1] unless account.country == 'US'
    account.legal_entity.personal_address.city = params[:merchant][:city] unless account.country == 'US'
    account.legal_entity.personal_address.postal_code = params[:merchant][:postal_code] unless account.country == 'US'
    account.legal_entity.address.state = params[:merchant][:state]
    account.legal_entity.ssn_last_4 = params[:merchant][:ssn_last_4] if params[:merchant][:ssn_last_4]
    account.legal_entity.personal_id_number = params[:merchant][:personal_id_number] if params[:merchant][:personal_id_number]
    account.default_currency = params[:merchant][:currency]

    account.save

    if account.save
      @merchant.update_attributes(
        first_name: params[:merchant][:first_name],
        last_name: params[:merchant][:last_name],
        month: params[:merchant][:month],
        day: params[:merchant][:day],
        year: params[:merchant][:year],
        currency: account.default_currency
      )
      if @merchant.save
        redirect_to instructor_path(@instructor)
        flash[:notice] = "You've updated your merchant account."
      else
        render 'edit'
      end
    else
      redirect_to instructor_path(@instructor)
      flash[:alert] = "Your merchant account failed to update."
    end

  end

  private

    def set_instructor
      @instructor = current_instructor
    end

    def correct_instructor
      @instructor = Instructor.friendly.find(params[:instructor_id])
      if current_instructor != @instructor
        redirect_to instructor_path(@instructor)
        flash[:alert] = "This is not you."
      end
    end

    def have_merchant_account
      @instructor = current_instructor
      if @instructor.merchant
        @merchant = @instructor.merchant
        redirect_to edit_instructor_merchants_path(@instructor, @merchant) if @merchant.country.present?
      end
    end

end