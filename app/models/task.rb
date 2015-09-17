# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  priority    :integer
#  due_date    :datetime
#  status      :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ActiveRecord::Base
  enum status: [ :active, :completed ]

  belongs_to :user

  def self.search(query)
    if query.blank?
      all
    else
      q = "%#{query}%"
      where("title ilike ?", q)
    end
  end
end
