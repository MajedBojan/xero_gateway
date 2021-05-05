module XeroGateway
  module OAuth2
    # Wraps an OAuth2::Response object to behave like XeroGateway
    # expects legacy, monkey-patched responses.
    class ResponseAdapter
      def initialize(response)
        @response = response
      end

      def code
        @response.status
      end

      def plain_body
        @response.body
      end
    end
  end
end
