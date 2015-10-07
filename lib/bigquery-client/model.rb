require 'ostruct'

module BigQuery
  class Relation < Array
  end

  class Tuple < OpenStruct
  end

  class Attribute
    def initialize(value, type)
      @value = value

      case type
      when 'String'
        String.new(value)
      when 'Integer'
        Integer.new(value)
      end

    end

    # 属性の名前のメソッドが定義されている -> define_method
    class String < Attribute
      def parse
        @value
      end
    end

    class Integer < Attribute
      def parse
        @value.to_i
      end
    end
  end
end

# ファイル名をリネーム
# relation と tuple でファイルをわける
# 実装ちゃんとする

