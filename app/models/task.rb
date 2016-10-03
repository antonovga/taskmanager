class Task < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  mount_uploader :attachment, AttachmentUploader
end
