class TodoItem < ActiveRecord::Base
  validates :title, presence: true
  belongs_to :user

  scope :filtered, -> { where(completed: false) }

  def self.search(term, user)
    user.todo_items.where("title ILIKE ?", "%#{term}%")
  end
end
