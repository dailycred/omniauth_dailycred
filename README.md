# Omniauth_Dailycred

This gem is intended for users who solely want to interact with [dailycred](https://www.dailycred.com) through omniauth. If you are looking into a more comprehensive authentication solution with dailycred, you should see our [rails engine](https://github.com/dailycred/dailycred).

##Installation

In your gemfile

~~~
gem 'omniauth_dailycred'
~~~

Then simply run `bundle`.

##Usage

Create an initializer at `config/initializers/omniauth.rb` with the following:

~~~
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dailycred, ENV['DAILYCRED_CLIENT_ID'], ENV['DAILYCRED_SECRET']
end
~~~

Then simply send your users to `auth/dailycred` and they will be forwarded through the OAuth flow. The following parameters can be passed along to dailycred:

1. action
1. identity_provider
1. referrer
1. access_token

If you run into an SSL Error, it's because omniauth can't find your ssl certicate. Try modifying `config/initializers/omniauth.rb` to look like the following:

~~~
opts = {:client_options => {:ssl => {}}}

if File.exists?('/etc/ssl/certs')
  opts[:client_options][:ssl][:ca_path] = '/etc/ssl/certs'
end
if File.exists?('/opt/local/share/curl/curl-ca-bundle.crt')
  opts[:client_options][:ssl][:ca_file] = '/opt/local/share/curl/curl-ca-bundle.crt'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dailycred, ENV['DAILYCRED_CLIENT_ID'], ENV['DAILYCRED_SECRET'], opts
end
~~~