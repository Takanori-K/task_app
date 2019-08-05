class Task < ApplicationRecord
  belongs_to :user
  validates :task_name, presence: true, length: { maximum: 50 }
  validates :details,   presence: true, length: { maximum: 200 }
end
