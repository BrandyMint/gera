class Admin::ExternalRatesController < Admin::ApplicationController
  def index
    if params[:rate_source_id].present?
      redirect_to admin_external_rate_snapshots_path(rate_source_id: params[:rate_source_id])
    else
      redirect_to admin_rate_sources_path
    end
  end

  def show
    render locals: {
      external_rate: external_rate
    }
  end

  private

  def external_rate
    Gera::ExternalRate.find params[:id]
  end
end
