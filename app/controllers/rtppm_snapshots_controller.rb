class RtppmSnapshotsController < ApplicationController
  respond_to :html

  def index
    @snapshot = RtppmSnapshot.order(imported_at: :desc).first
    respond_with @snapshot
  end
end
