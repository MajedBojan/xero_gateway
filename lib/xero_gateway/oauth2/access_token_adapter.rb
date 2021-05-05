module XeroGateway
  module OAuth2
    # Wraps an OAuth2::AccessToken object to behave like XeroGateway
    # expects a legacy OAuth client object to behave for executing
    # requests.
    class AccessTokenAdapter
      def initialize(token, xero_tenant_id)
        @token = token
        @xero_tenant_id = xero_tenant_id
      end

      def get(uri, headers)
        wrap_request(:get, uri, { headers: headers_with_tenant(headers) })
      end

      def post(uri, params, headers)
        wrap_request(:post, uri, params.dup.merge(headers: headers_with_tenant(headers)))
      end

      def put(uri, params, headers)
        wrap_request(:put, uri, params.dup.merge(headers: headers_with_tenant(headers)))
      end

      protected

      def wrap_request(method, uri, opts)
        ResponseAdapter.new(@token.request(method, uri, opts))
      end

      def headers_with_tenant(headers)
        { xero_tenant_id: @xero_tenant_id }.merge(headers)
      end
    end
  end
end
