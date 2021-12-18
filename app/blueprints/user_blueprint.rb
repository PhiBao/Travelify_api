# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  first_name             :string
#  last_name              :string
#  password_digest        :string
#  email                  :string
#  phone_number           :string
#  address                :string
#  birthday               :date
#  activation_digest      :string
#  activated_at           :datetime
#  activated              :boolean          default(FALSE)
#  admin                  :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  reset_password_digest  :string
#  reset_password_sent_at :datetime
#  provider               :string
#  uid                    :string
#
class UserBlueprint < Blueprinter::Base

  identifier :id
  fields :first_name, :last_name, :email, :phone_number,
         :address, :birthday, :activated, :admin, :created_at
  field :avatar_data, name: :avatar
end