class Message < ApplicationRecord
  # belongs_to :team
  # belongs_to :user
  #with after_create hook this job runs before we actually committed new record to the database.
  #which will lead to error
  after_create_commit {MessageBroadcastJob.perform_later self }
end