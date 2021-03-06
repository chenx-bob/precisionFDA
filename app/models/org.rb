# == Schema Information
#
# Table name: orgs
#
#  id         :integer          not null, primary key
#  handle     :string
#  name       :string
#  admin_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  address    :text
#  duns       :string
#  phone      :string
#  state      :string
#  singular   :boolean
#

class Org < ActiveRecord::Base
  has_many :users
  belongs_to :admin, {class_name: 'User'}

  def self.construct_dxorg(handle)
    raise unless handle.present? && handle =~ /^[0-9a-z][0-9a-z_.]*$/
    "org-pfda..#{handle}"
  end

  def self.featured
    Org.find_by(handle: 'precisionfda')
  end

  def dxorg
    Org.construct_dxorg(handle)
  end
end
