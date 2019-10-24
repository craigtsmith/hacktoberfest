# frozen_string_literal: true

module FetchSpamRepositoriesService
  module_function

  def call
    spam_repo_ids = AirrecordTable.new.all_records('Spam Repos').map do |repo|
      repo['Repo ID']&.to_i if repo['Verified?']
    end.compact

    spam_repo_ids.each do |spam_repo_id|
      SpamRepositry.first_or_create(github_id: spam_repo_id)
    end
  end
end
