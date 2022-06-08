=begin
#Mailchimp Marketing API

#No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)

OpenAPI spec version: 3.0.75
Contact: apihelp@mailchimp.com
Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.4.12

=end

require 'uri'

module MailchimpMarketing
  class VerifiedDomainsApi
    attr_accessor :api_client

    def initialize(api_client)
      @api_client = api_client
    end

    # Add domain to account
    def create_verified_domain(body, opts = {})
      fail ArgumentError, "Missing required param: 'body'" if body.nil?

      query_params = {}
      post_body = @api_client.object_to_http_body(body)

      local_var_path = '/verified-domains'
      data = @api_client.call_api(:POST, local_var_path,
        :query_params => query_params,
        :body => post_body)
      return data
    end

    # Delete domain
    def delete_domain(domain_name, opts = {})
      fail ArgumentError, "Missing required param: 'domain_name'" if domain_name.nil?

      query_params = {}
      post_body = nil

      local_var_path = '/verified-domains/{domain_name}'.sub('{' + 'domain_name' + '}', domain_name.to_s)
      data = @api_client.call_api(:DELETE, local_var_path,
        :query_params => query_params,
        :body => post_body)
      return data
    end

    # Get domain info
    def get_domain(domain_name, opts = {})
      fail ArgumentError, "Missing required param: 'domain_name'" if domain_name.nil?

      query_params = {}
      post_body = nil

      local_var_path = '/verified-domains/{domain_name}'.sub('{' + 'domain_name' + '}', domain_name.to_s)
      data = @api_client.call_api(:GET, local_var_path,
        :query_params => query_params,
        :body => post_body)
      return data
    end

    # List sending domains
    def get_verified_domains_all(opts = {})

      query_params = {}
      post_body = nil

      local_var_path = '/verified-domains'
      data = @api_client.call_api(:GET, local_var_path,
        :query_params => query_params,
        :body => post_body)
      return data
    end

    # Verify domain
    def submit_domain_verification(domain_name, body, opts = {})
      fail ArgumentError, "Missing required param: 'domain_name'" if domain_name.nil?
      fail ArgumentError, "Missing required param: 'body'" if body.nil?

      query_params = {}
      post_body = @api_client.object_to_http_body(body)

      local_var_path = '/verified-domains/{domain_name}/actions/verify'.sub('{' + 'domain_name' + '}', domain_name.to_s)
      data = @api_client.call_api(:POST, local_var_path,
        :query_params => query_params,
        :body => post_body)
      return data
    end
  end
end
