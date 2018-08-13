class PackagesController < ApplicationController
  def index
    @packages = PackageVersion.order(:publication_date)

    if params[:q].present?
      @packages = @packages.joins(:package)
        .where(
          Package.arel_table[:name].matches("%#{params[:q]}%")
          .or(PackageVersion.arel_table[:title].matches("%#{params[:q]}%")
            .or(PackageVersion.arel_table[:description].matches("%#{params[:q]}%")))
        )
    end
  end
end
