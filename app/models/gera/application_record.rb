# frozen_string_literal: true

module Gera
  # @abstract
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true
    default_scope { order(created_at: :asc) }
  end
end
