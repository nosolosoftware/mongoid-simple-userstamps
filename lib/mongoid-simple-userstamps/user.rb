##
# This module define stamps model
#
module Mongoid
  module Userstamps
    module User
      def self.included(base)
        Mongoid::Userstamps::Config.set_model(self)
      end
    end
  end
end
