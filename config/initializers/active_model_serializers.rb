# config/initializers/active_model_serializers.rb
ActiveModelSerializers.config.adapter = :json # Default
ActiveModelSerializers.config.json_api_configure do |c|
  c.default_format = :json
end

ActiveModelSerializers.config.json_key_format = :unaltered
ActiveModelSerializers.config.serialization_scope = nil