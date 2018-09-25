class Admin::ExternalRateSnapshotsController < Admin::ApplicationController
  PER_PAGE = 200
  helper_method :rate_source

  def index
    render locals: {
      snapshots: snapshots
    }
  end

  def show
    snapshot = ExternalRateSnapshot.find params[:id]

    render locals: {
      snapshot: snapshot
    }
  end

  private

  def rate_source
    Gera::RateSource.find params[:rate_source_id]
  end

  def snapshots
    rate_source.snapshots.ordered.page(params[:page]).per(params[:per] || PER_PAGE)
  end
end
