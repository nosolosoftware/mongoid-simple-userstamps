##
# This module add user stamps to class
#
module Mongoid
  module Userstamps
    module Model
      def self.included(base)
        base.class_eval do
          attr_reader :skip_userstamps_flag

          if Mongoid::VERSION.to_f < 6
            belongs_to :created_by, polymorphic: true
            belongs_to :updated_by, polymorphic: true
          else
            belongs_to :created_by, polymorphic: true, optional: true
            belongs_to :updated_by, polymorphic: true, optional: true
          end

          before_create do
            unless @skip_userstamps_flag || created_by
              self.created_by = Mongoid::Userstamps::User.current
            end
          end

          before_update do
            unless @skip_userstamps_flag || updated_by_id_changed?
              self.updated_by = Mongoid::Userstamps::User.current
            end
          end

          after_save do
            @skip_userstamps_flag = false
          end

          def skip_userstamps
            @skip_userstamps_flag = true
            self
          end
        end
      end
    end
  end
end
