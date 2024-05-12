# Paymob::Engine
This gem simplifies the integration of your application with the [Paymob](https://paymob.com/) payment gateway. It offers a set of user-friendly methods for creating one-time payments, wallet payments, and installment payments, streamlining the payment process for your application. By using this gem, developers can easily implement a robust payment solution in their projects.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "paymob-engine"
```

And then execute:
```bash
bundle
```

Or install it yourself as:
```bash
gem install paymob-engine
```

## Usage
### 1. Set the Gem Configuration Variables
you must configure it with the necessary credentials and settings. you will find all variables in `config/initializers/paymob.rb` file

```ruby
Paymob.setup do |config|
  config.base_url = 'https://accept.paymobsolutions.com/api'
  config.api_key = ''
  config.hmac_secret = ''
  config.onetime_integration_id = ''
  config.wallet_integration_id = ''
  config.installment_integration_id = ''
  config.ifream_link = 'https://accept.paymobsolutions.com/api/acceptance/iframes/'
  config.onetime_ifream_number = ''
  config.installment_ifream_number = ''
end
```

**Note**: `api_key`, `hmac_secret` are mandatory and each payment type variables are mandatory if you need use this payment type.

You can found all information in your [dashboard](https://accept.paymob.com/portal2/en/home).

### 2. Create an Object to Use for Payments

create an instance of the payment object to use it to create all payment types:

```ruby
paymob_object = Paymob::Payment.new
```
### 3. Create a One-Time Payment
use the `create_one_time_payment` method:

```ruby
payment_data = {
  amount: "Your value in numbers", 
  billing_data: {
    first_name: "Test", 
    last_name: "Account",
    email: "test@email.com",
    phone_number:"01111111111"
  }, 
  payment_reference: "Your generated payment reference"
}
paymob_object.create_onetime_payment(payment_data)
```
**Note**: the required billing data keys are [`first_name`, `last_name`, `email`, `phone_number`]


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
