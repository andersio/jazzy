module Jazzy
  class SourceMark
    attr_accessor :name
    attr_accessor :has_start_dash
    attr_accessor :has_end_dash
    attr_accessor :is_extension_constraint

    def initialize(mark_string = nil, is_extension_constraint = false)
      self.is_extension_constraint = is_extension_constraint

      return unless is_extension_constraint || mark_string

      unless is_extension_constraint
        # Format: 'MARK: - NAME -' with dashes optional
        mark_string.sub!(/^MARK: /, '')
      end

      if !is_extension_constraint && mark_string.empty?
        # Empty
        return
      elsif mark_string == '-'
        # Separator
        self.has_start_dash = true
        return
      end

      self.has_start_dash = mark_string.start_with?('- ')
      self.has_end_dash = mark_string.end_with?(' -')

      start_index = has_start_dash ? 2 : 0
      end_index = has_end_dash ? -3 : -1

      self.name = mark_string[start_index..end_index]
    end
  end
end
