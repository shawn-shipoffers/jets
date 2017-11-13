class Jets::Cfn::TemplateMappers
  class GatewayMethodMapper
    def initialize(route)
      @route = route # {to: "posts#index", path: "posts", method: :get}
    end

    def logical_id
      "#{path_method_id}ApiGatewayMethod"
    end

    def path_method_id
      path = @route.path.gsub(':','_').gsub('/','_')
      method = @route.method.downcase
      "#{path}_#{method}".camelize
    end

    # Example returns:
    #   ApiGatewayResourcePostsIdEdit or
    #   ApiGatewayResourcePostsId or
    #   ApiGatewayResourcePosts
    def gateway_resource_logical_id
      resource_map.logical_id
    end

    def cors_logical_id
      resource_map.cors_logical_id
    end

    def resource_map
      @resource_map ||= GatewayResourceMapper.new(@route.path)
    end

    def lambda_function_logical_id
      "#{controller_action}LambdaFunction"
    end

    def permission_logical_id
      "#{controller_action}ApiGatewayPermission"
    end

    # Example: PostsControllerIndex
    def controller_action
      controller, action = @route.to.split('#')
      "#{controller}_controller_#{action}".camelize
    end

    def controller
      controller, action = @route.to.split('#')
      "#{controller}_controller".camelize
    end
  end
end