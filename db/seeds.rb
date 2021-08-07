require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

LoadVariant.new(variant_name: 'simple').call
LoadVariant.new(variant_name: 'classic').call
