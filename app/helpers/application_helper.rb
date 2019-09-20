module ApplicationHelper
    def full_title(title)
        base_title = "Trike World Ltd."
        if title
            "#{title} | #{base_title}"
        else
            base_title
        end
    end
end
