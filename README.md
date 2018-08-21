[![Build Status](https://travis-ci.org/denmarkmeralpis/itexmo.svg?branch=master)](https://travis-ci.org/denmarkmeralpis/itexmo)  [![Maintainability](https://api.codeclimate.com/v1/badges/e31181fc348630563d8e/maintainability)](https://codeclimate.com/github/denmarkmeralpis/itexmo/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/e31181fc348630563d8e/test_coverage)](https://codeclimate.com/github/denmarkmeralpis/itexmo/test_coverage) [![Gem Version](https://badge.fury.io/rb/itexmo.svg)](https://badge.fury.io/rb/itexmo)

# iTexMo Ruby Plugin
A ruby plugin that uses the iTexMo REST API. You can send SMS using itextmo gem without hassle.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itexmo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itexmo

Finally, generate initializer
    
    $ rails g initializer:itexmo initializer
    
this will create a file under `config/initializer/itexmo.rb` Note: `api_code` should be supplied inside the itextmo.rb.

## Usage
### I. Sending an SMS
Two ways of sending SMS
```ruby
message = Itexmo::Message.new(message: 'Your awesome message!', to: '0917XXXXXXX')
message.send
```
or simply:

```ruby
Itexmo::Message.send(message: 'Your awesome message!', to: '0917XXXXXXXX')
```

### II. Checking of Service
```ruby
#Check API Service Status and your SMS Server Status
Itexmo::Service.status

# Check `api_code` Info and Status
Itexmo::Service.apicode_info
```
### III. SMS Reports/Actions
```ruby
# Show Pending or Outgoing SMS:
Itexmo::Sms.display_outgoing('desc') # default order is 'asc'

# Delete All Pending or Outgoing SMS:
Itexmo::Sms.delete_all_outgoing

# Return All SMS Received (Corporate Premium Apicodes)
Itexmo::Sms.display_messages 

# Return All SMS Received using Originator as Filter (Corporate Premium Apicodes)
Itexmo::Sms.display_messages_via_originator('0917XXXXXXX')

# Delete All SMS Received using Originator as Filter (Corporate Premium Apicodes)
Itexmo::Sms.delete_message_via_originator('0917XXXXXXX')

# Delete an SMS Received using SMS ID as filter (Corporate Premium Apicodes)
Itexmo::Sms.delete_message_via_id('105')

# Delete All SMS Received (Corporate Premium Apicodes)
Itexmo::Sms.delete_messages_all
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/denmarkmeralpis/itexmo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Itexmo project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[denmarkmeralpis]/itexmo/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://github.com/denmarkmeralpis/itexmo/blob/master/LICENSE.txt).

## Donate

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=nujiandenmarkmeralpis@gmail.com&lc=US&item_name=For+Living&no_note=0&cn=&curency_code=USD&bn=PP-DonationsBF:btn_donateCC_LG.gif:NonHosted)
