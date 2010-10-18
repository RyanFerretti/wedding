# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Wedding_session',
  :secret      => '8ea8d55bb03b7339955fec7f1ab7c52a069e0f7895143af51e74730f30e3a35610f21a408208276c2c0d4ff9dd481d01ebc0e6bcd31e9cc621c8ea22a3dd56a3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
