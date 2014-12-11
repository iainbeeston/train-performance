class RtppmSnapshotsController < ApplicationController
  respond_to :html

  def show
    @snapshot = RtppmSnapshot.order(imported_at: :desc).first
    respond_with @snapshot
  end
end
