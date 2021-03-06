class TourBlueprint < Blueprinter::Base
  identifier :id
  fields :name, :kind, :description, 
         :departure, :created_at
  field :images_data, name: :images
  field :price_formatter, name: :price

  view :normal do
    fields :details, :rate
    field :vehicles_data, name: :vehicles
    field(:marked, if: ->(_field_name, _tour, options) { options[:user].present? }) do |tour, options|
      tour.actions.mark.find_by(user_id: options[:user].id).present?
    end
    association :tags, blueprint: TagBlueprint, view: :normal
  end

  view :detail do
    include_view :normal
    association :reviews, blueprint: ReviewBlueprint do |tour, options|
      if options[:user]&.admin?
        tour.reviews.newest.page(1)
      else
        tour.reviews.appear.newest.page(1)
      end
    end
    field :size do |tour, options|
      if options[:user]&.admin?
        tour.reviews.size
      else
        tour.reviews.appear.size
      end
    end
  end

  view :admin do
    fields :limit, :time, :begin_date, :return_date
    association :vehicles, blueprint: VehicleBlueprint
    association :tags, blueprint: TagBlueprint, view: :option
  end
end
