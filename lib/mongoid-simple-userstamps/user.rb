##
# This module define stamps model
#
module Mongoid
  module Userstamps
    module User
      def self.current
        Thread.current[:current_user]
      end

      def self.current=(current)
        Thread.current[:current_user] = current
      end
    end
  end
end
