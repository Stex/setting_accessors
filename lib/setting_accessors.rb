# frozen_string_literal: true

require 'active_record'
require 'active_model/validations'

require 'setting_accessors/version'
require 'setting_accessors/helpers'
require 'setting_accessors/accessor_generator'
require 'setting_accessors/converters/base'
require 'setting_accessors/converters/boolean_converter'
require 'setting_accessors/converters/integer_converter'
require 'setting_accessors/converters/string_converter'
require 'setting_accessors/converters/polymorphic_converter'
require 'setting_accessors/integration'
require 'setting_accessors/internal'
require 'setting_accessors/setting_scaffold'
require 'setting_accessors/setting_set'

ActiveRecord::Base.class_eval do
  include SettingAccessors::Integration
end

module SettingAccessors
  class Error < StandardError; end
  class NestedHashKeyNotFoundError < Error; end
  class SettingNotFoundError < Error; end

  def self.setting_class
    setting_class_name.constantize
  end

  def self.setting_class=(klass)
    @@setting_class = klass.to_s
  end

  def self.setting_class_name
    (@@setting_class ||= 'Setting').camelize
  end
end
