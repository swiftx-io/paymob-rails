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


### 2. How to Initialize an Order for new payment

Each payment method class inherits from a base class. To initiate a payment, select the class corresponding to the desired payment type. Start by invoking the `initialize_order` method with essential attributes, including a float `amount`, a string `payment_reference`, and a hash for `billing_data` containing required keys: `first_name`, `last_name`, `email`, and `phone_number`. Subsequently, use the `payment_link` method to obtain the payment link.

The available class for each payment type are:
- `Paymob::PaymentTypes::Onetime`
- `Paymob::PaymentTypes::Wallet`
- `Paymob::PaymentTypes::Installment`

### 3. Create an One-Time Payment
Use the `Paymob::PaymentTypes::Onetime` class:

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
onetime = Paymob::PaymentTypes::Onetime.new
onetime.initialize_order(payment_data)
onetime.payment_link
```

### 4. Create a Wallet Payment
Use the `Paymob::PaymentTypes::Wallet` class:

`Note`: you must pass the mobile number wallet you need to pay from it
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
onetime = Paymob::PaymentTypes::Wallet.new
onetime.initialize_order(payment_data)
onetime.payment_link(mobile_number: '01010101010')
```

### 5. Create an Installment Payment
Use the `Paymob::PaymentTypes::Installment` class:
```ruby
payment_data = {
  amount: "10", 
  billing_data: {
    first_name: "Test", 
    last_name: "Account",
    email: "test@email.com",
    phone_number:"01111111111"
  }, 
  payment_reference: "ERTY"
}
onetime = Paymob::PaymentTypes::Installment.new
onetime.initialize_order(payment_data)
onetime.payment_link
```

## How to evaluate the HMAC
The `Paymob::Hmac` class provides helpful methods for handling HMAC operations. Below are the explanations of each method:

`calculate`

This method accepts a hash of parameters and returns the HMAC for these parameters.

Example: 
```ruby
hmac = Paymob::Hmac.calculate(params_hash) # 6d9bb40e5b46b7166bb032cb075c8921
```

`matches_original?`

This method compares the HMAC generated from the provided parameters with an original HMAC and returns a boolean value indicating whether they match.

```ruby
match = Paymob::Hmac.matches_original?(response_params, original_hmac) # true
```
## Contributing

We welcome contributions to improve paymob-rails! Whether you want to fix a bug, implement a new feature, or suggest improvements, we appreciate your efforts.

To contribute to this project, follow these steps:

1. **Fork the Repository**: Start by forking the repository to your GitHub account.

2. **Clone the Repository**: Clone the forked repository to your local machine.

3. **Create a Branch**: Create a new branch for your contribution.

4. **Make Changes**: Make your desired changes to the codebase.

5. **Test**: Ensure that the changes you made pass all existing tests, and if necessary, add new tests to cover the changes.

6. **Commit Changes**: Commit your changes with a descriptive commit message.

7. **Push Changes**: Push your changes to your forked repository.

8. **Create a Pull Request**: Go to the [original repository](link-to-your-repo) and create a pull request. Be sure to provide a detailed description of your changes and the problem they solve.

9. **Review**: Once your pull request is submitted, it will be reviewed by the maintainers. You may need to address any feedback or comments before it can be merged.

Thank you for considering contributing to paymob-rails! Your involvement makes this project better for everyone.

Feel free to customize this template to suit the specific guidelines and processes of your project.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
