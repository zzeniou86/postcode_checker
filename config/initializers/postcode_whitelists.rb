PC_WHITELIST = YAML.load_file("#{Rails.root.join('config')}/whitelists.yml").symbolize_keys!
