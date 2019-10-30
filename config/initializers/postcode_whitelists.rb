PC_WHITELIST = YAML.load_file("#{Rails.root}/config/whitelists.yml").symbolize_keys!
