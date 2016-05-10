##
# This module add user stamps to class
#
module Mongoid
  module Userstamps
    module Model
      def self.included(base)
        base.send(:belongs_to, :created_by, {polymorphic: true})
        base.send(:belongs_to, :updated_by, {polymorphic: true})

        base.send(:before_create) do
          if Mongoid::Userstamps::Config.current && !self.created_by
            self.created_by = Mongoid::Userstamps::Config.current
          end
        end

        base.send(:before_update) do
          if Mongoid::Userstamps::Config.current
            self.updated_by = Mongoid::Userstamps::Config.current
          end
        end
      end
    end
  end
end
