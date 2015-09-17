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
  
  validates :title, presence: true
  validates :priority, numericality: { greater_than_or_equal_to: 1 }
  validates :description, length: { maximum: 300 }
  validate :correct_due_date?

  belongs_to :user
  
  default_scope ->{ order(priority: :desc) }

  def self.search(query)
    if query.blank?
      all
    else
      q = "%#{query}%"
      where("title ilike ?", q)
    end
  end

  private
    def correct_due_date?
      if due_date.present? && due_date <= DateTime.now
        errors.add(:due_date, "can't be in the past")
      end
    end
end
