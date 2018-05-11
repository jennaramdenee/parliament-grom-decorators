module Parliament
  module Grom
    module Decorator
      # Decorator namespace for Grom::Node instances with type: https://id.parliament.uk/schema/StatutoryInstrument
      module StatutoryInstrument
        # Alias statutoryInstrumentNumberPrefix with fallback.
        #
        # @return [String, String] a number prefix string or an empty string.
        def number_prefix
          respond_to?(:statutoryInstrumentNumberPrefix) ? statutoryInstrumentNumberPrefix : ''
        end

        # Alias statutoryInstrumentNumber with fallback.
        #
        # @return [String, String] an instrument number string or an empty string.
        def instrument_number
          respond_to?(:statutoryInstrumentNumber) ? statutoryInstrumentNumber : ''
        end

        # Alias statutoryInstrumentNumberYear with fallback.
        #
        # @return [String, String] a number year string or an empty string.
        def number_year
          respond_to?(:statutoryInstrumentNumberYear) ? statutoryInstrumentNumberYear : ''
        end

        # Full citation for the statutory instrument.
        #
        # @return [String, String] a citation or an empty string.
        def citation
          "#{number_prefix} number #{number_year}/#{instrument_number}" if !number_prefix.empty? && !number_year.empty? && !instrument_number.empty?
        end

      end
    end
  end
end
