class RtppmSnapshotsController < ApplicationController
  respond_to :html

  def show
    @snapshot = RtppmSnapshot.most_recent.first
    respond_with @snapshot
  end

  def update
    if !RtppmSnapshot.up_to_date?
      RtppmSnapshot.import
    end

    head :no_content
  end
end
