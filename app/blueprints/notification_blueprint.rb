class NotificationBlueprint < Blueprinter::Base
  identifier :id
  fields :action, :notifiable_type, :tour_id, :status, :created_at
  association :user, blueprint: UserBlueprint, view: :short  
end