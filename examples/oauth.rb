require 'rubygems'
require 'pp'

require File.dirname(__FILE__) + '/../lib/xero_gateway.rb'
# client1 = Xeroizer::OAuth2Application.new('NJJT5P4CUKX7CQZB365B6KTYAZDBX0', 'NJJT5P4CUKX7CQZB365B6KTYAZDBX0')

XERO_CONSUMER_KEY    = 'NJJT5P4CUKX7CQZB365B6KTYAZDBX0'
XERO_CONSUMER_SECRET = '3FGNRB1X8X3BEKWV5XZ36YPDPKABPE'

gateway = XeroGateway::Gateway.new(XERO_CONSUMER_KEY, XERO_CONSUMER_SECRET,
                                   { oauth2_access_token: '3FGNRB1X8X3BEKWV5XZ36YPDPKABPE', oauth2_tenant_id: 'NJJT5P4CUKX7CQZB365B6KTYAZDBX0' })

# authorize in browser
`open #{gateway.request_token.authorize_url}`

puts 'Enter the verification code from Xero?'
oauth_verifier = gets.chomp

gateway.authorize_from_request(gateway.request_token.token, gateway.request_token.secret, oauth_verifier: '6313916')

puts "Your access token: #{gateway.access_token}"
puts '(Good for 30 minutes)'

# Example API Call
pp gateway.get_contacts.contacts

