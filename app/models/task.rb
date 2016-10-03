class Task < ApplicationRecord
  include AASM

  belongs_to :user

  validates :name, presence: true

  mount_uploader :attachment, AttachmentUploader

  aasm column: :state, whiny_transitions: false do
    state :new, initial: true
    state :started
    state :finished

    event :start do
      transitions from: :new, to: :started
    end

    event :finish do
      transitions from: :started, to: :finished
    end
  end
end
