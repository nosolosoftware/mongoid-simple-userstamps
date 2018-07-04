##
# This module add user stamps to class
#
module Mongoid
  module Userstamps
    module Model
      def self.included(base)
        base.class_eval do
          if Mongoid::VERSION.to_f < 6
            belongs_to :created_by, polymorphic: true
            belongs_to :updated_by, polymorphic: true
          else
            belongs_to :created_by, polymorphic: true, optional: true
            belongs_to :updated_by, polymorphic: true, optional: true
          end

          before_create do
            self.created_by = Mongoid::Userstamps::User.current unless created_by
          end

          before_update do
            self.updated_by = Mongoid::Userstamps::User.current unless updated_by_id_changed?
          end
        end
      end
    end
  end
end
