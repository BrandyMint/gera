class Admin::DirectionRatesController < Admin::ApplicationController
  layout 'admin/wide'

  authority_actions legacy: :read, last: :read, minimals: :read

  def last
    exchange_rate = direction_rate.exchange_rate
    dr = Gera::Universe.direction_rates_repository.find_direction_rate_by_exchange_rate_id exchange_rate.id

    redirect_to admin_direction_rate_path(dr), flash: { success: "Перекинули на страницу курса от #{I18n.l dr.created_at, format: :long}" }
  end

  def show
    render locals: {
      direction_rate: direction_rate
    }
  end

  private

  def direction_rate
    @direction_rate ||= Gera::DirectionRate.find params[:id]
  end
end
