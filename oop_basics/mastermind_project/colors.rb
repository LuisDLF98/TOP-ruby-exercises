class String
    def color(code)
        "\e[#{code}m#{self}\e[0m"
    end

    def bg_red
        color(41)
    end

    def bg_green
        color(42)
    end

    def bg_yellow
        color(43)
    end

    def bg_blue
        color(44)
    end

    def bg_magenta
        color(45)
    end

    def bg_cyan
        color(46)
    end

    def red
        color(31)
    end

    def grey
        color(37)
    end
end