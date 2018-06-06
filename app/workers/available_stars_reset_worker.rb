class AvailableStarsResetWorker
  include Sidekiq::Worker

  def perform()
    organizations = Organization.all
    organizations.each do |org|
      org.star_bags.update(available_stars: org.stars_by_month)
    end
  end
end
