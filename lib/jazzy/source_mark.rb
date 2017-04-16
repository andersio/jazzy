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

      if is_extension_constraint
        mark_string.sub!(/Value\s?\:\s?Signal(Producer)?Protocol\,\s?Error\s?\=\=\s?([a-zA-Z0-9\.]+)/, 'Value == Signal$1<Value.Value, $2>')
        mark_string.sub!(/Value\s?\:\s?Signal(Producer)?Protocol/, 'Value == Signal$1<Value.Value, Error>')
        mark_string.sub!(/Value\s?\=\=\s?EventProtocol/, '<U, E> Value == Event<U, E>')
        mark_string.sub!(/Value\s?\=\=\s?OptionalProtocol/, '<U> Value == U?')
        self.name = mark_string
      else
        if mark_string.empty?
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
end
