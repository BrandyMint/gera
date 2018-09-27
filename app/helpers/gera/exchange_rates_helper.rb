module Gera::ExchangeRatesHelper
  def exchange_rate_cell_class(er)
    return unless er
    classes = []

    classes << 'rate-popover' if show_direction_popover?

    if er.comission_percents <= 0
      classes << 'text-danger'
    else
      classes << 'text-success'
    end

    classes.join ' '
  end
end
