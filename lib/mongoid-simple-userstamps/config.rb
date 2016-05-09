##
# This module store Userstamps config
#
module Mongoid
  module Userstamps
    module Config
      @@model = nil
      @@current = nil

      def self.current
        @@current
      end

      def self.model
        @@model
      end

      def self.set_current(current)
        @@current = current
      end

      def self.set_model(user_class)
        @@user_class = user_class
      end
    end
  end
end
