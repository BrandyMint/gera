class Admin::CurrencyRateModeSnapshotsController < Admin::ApplicationController
  authorize_actions_for Gera::CurrencyRateMode
  authority_actions activate: :create

  helper_method :view_mode

  def index
    redirect_to edit_admin_currency_rate_mode_snapshot_path  Gera::Universe.currency_rate_modes_repository.snapshot
  end

  def edit
    if snapshot.status_draft?
      render :edit, locals: {
        snapshot: snapshot
      }
    else
      redirect_to admin_currency_rate_mode_snapshot_path snapshot
    end
  end

  def show
    if snapshot.status_draft?
      redirect_to edit_admin_currency_rate_mode_snapshot_path snapshot
    else
      render :edit, locals: {
        snapshot: snapshot
      }
    end
  end

  def activate
    snapshot.transaction do
      Gera::Gera::CurrencyRateModeSnapshot.status_active.update_all status: :deactive
      snapshot.update status: :active
    end
    Gera::CurrencyRatesWorker.perform_async if Rails.env.production?
    flash[:success] = 'Режимы активированы'
    redirect_to admin_currency_rate_mode_snapshot_path snapshot
  end

  def update
    snapshot.update permitted_params
    respond_to do |format|
      format.json { respond_with_bip(snapshot) }
    end
  end

  def create
    flash[:success] = 'Создана новая матрица методов расчета'
    redirect_to edit_admin_currency_rate_mode_snapshot_path(create_draft_snapshot)
  end

  private

  def view_mode
    if params[:view_mode] == 'calculations'
      :calculations
    else
      :methods
    end
  end

  def snapshot
    Gera::CurrencyRateModeSnapshot.find params[:id]
  end

  def find_last_draft_snapshot
    Gera::CurrencyRateModeSnapshot.status_draft.last
  end

  def create_draft_snapshot
    Gera::CurrencyRateModeSnapshot.create!
  end

  def permitted_params
    params.require(:currency_rate_mode_snapshot).permit!
  end
end
