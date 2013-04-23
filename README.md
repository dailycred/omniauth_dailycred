# Omniauth_Dailycred

This gem is intended for users who solely want to interact with [dailycred](https://www.dailycred.com) through omniauth. If you are looking into a more comprehensive authentication solution with dailycred, you should see our [rails engine](https://github.com/dailycred/dailycred).

Because we've extracted OAuth login from the [Rails engine](https://github.com/dailycred/dailycred) into its own [omniauth gem](https://github.com/dailycred/omniauth_dailycred), it's now extremely easy to implement dailycred in an existing project.

## Why?

Even if you've already set up authentication, Dailycred can be extremely helpful as a proxy for other authentication providers. For example:

* Not all OAuth providers allow you to pass state, and none of them allow you to pass additional parameters like ['referrer'](https://www.dailycred.com/api/server-side).
* You get instant access to a [comprehensive dashboard](https://www.dailycred.com/demo) to view your users and get a deeper insight into their behavior.
* Only implement one omniauth provider, and then send your user to any [identity provider](https://www.dailycred.com/api/providers) by sending them to the following route:

	/auth/dailycred?identity_provider=[provider]
	


##Installation

In your gemfile

~~~
gem 'omniauth_dailycred'
~~~

Then run `bundle`.

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

Follow the omniauth instructions to [integrate omniauth into your application](https://github.com/intridea/omniauth#integrating-omniauth-into-your-application) for further setup details.

In your *callback*, `request.env['omniauth.auth']` will look something like the following:

~~~
{
       "provider" => "dailycred",
            "uid" => "userid-xx-yy",
           "info" => {
                 "token" => "token-xxyy-token",
              "provider" => "dailycred",
                   "uid" => "userid-xx-yy",
                   "ban" => false,
             "user_type" => "CONVERTED",
            "identities" => {},
               "display" => "test@test.com",
                "emails" => {},
               "picture" => "https://www.dailycred.com/user/pic?user_id=userid-xx-yy&size=50",
            "updated_at" => 1366670682849,
               "created" => Mon, 15 Apr 2013 18:20:28 +0000,
                 "email" => "test@test.com",
        "last_logged_in" => 1366670682848,
              "verified" => false,
                 "guest" => false,
            "attributes" => {},
         "access_tokens" => {
            "dailycred" => "token-xxyy-token"
        },
          "access_token" => "token-xxyy-token"
    },
    "credentials" => {
          "token" => "token-xxyy-token",
        "expires" => false
    },
          "extra" => {}
}
~~~

