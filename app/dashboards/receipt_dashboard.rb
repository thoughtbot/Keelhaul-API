require "administrate/base_dashboard"

class ReceiptDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    id: Field::Number,
    token: Field::String,
    data: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    environment: Field::String.with_options(searchable: false),
    metadata: Field::String.with_options(searchable: false),
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :id,
    :token,
    :data,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :id,
    :token,
    :data,
    :created_at,
    :updated_at,
    :environment,
    :metadata,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :token,
    :data,
    :environment,
    :metadata,
  ]

  # Overwrite this method to customize how receipts are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(receipt)
  #   "Receipt ##{receipt.id}"
  # end
end
