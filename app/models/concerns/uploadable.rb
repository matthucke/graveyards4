module Uploadable
  extend ActiveSupport::Concern

  module ClassMethods
    def load_config config_path, env=Rails.env
      full = YAML.load(File.read(config_path))
      
      full[env].tap do |config|
        if !config || config.empty?
          raise "Cannot find '#{env}' at top level of #{full}; valid keys are #{full.keys}"
        end

      end

    end
    
    def configure_upload field_name, config_path
      conf = load_config(config_path)

      has_attached_file field_name, conf

      validates_attachment field_name, content_type: {
          content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
      }, on: :create

      # do NOT do presence: true here - allow it to be blank.
      # Otherwise it is not possible to update photos created before the Paperclip
      # migration, as their upload fields are blank.
    end
    
  end
end
